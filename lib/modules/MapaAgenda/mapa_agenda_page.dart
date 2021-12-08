import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'package:assistsaude/modules/Agenda/calendario_controller.dart';
import 'package:assistsaude/modules/Login/login_controller.dart';
import 'package:assistsaude/modules/MapaAgenda/mapa_agenda_controller.dart';
import 'package:assistsaude/shared/delete_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:cached_network_marker/cached_network_marker.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class MapaAgendaPage extends StatefulWidget {
  const MapaAgendaPage({Key? key}) : super(key: key);

  @override
  _MapaAgendaPageState createState() => _MapaAgendaPageState();
}

class _MapaAgendaPageState extends State<MapaAgendaPage> {
  CalendarioController calendarioController = Get.put(CalendarioController());
  final MapaAgendaController mapaAgendaController =
      Get.put(MapaAgendaController());
  Completer<GoogleMapController> _controller = Completer();

  LoginController loginController = Get.find(tag: 'login');

  Future<void> gotoLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(
          mapaAgendaController.lat.value, mapaAgendaController.lng.value),
      zoom: 18,
      tilt: 20,
      bearing: 45,
    )));
  }

  Future<void> zoomToFit(GoogleMapController controller, LatLngBounds bounds,
      LatLng centerBounds) async {
    bool keepZoomingOut = true;
    while (keepZoomingOut) {
      final LatLngBounds screenBounds = await controller.getVisibleRegion();
      if (fits(bounds, screenBounds)) {
        keepZoomingOut = false;
        final double zoomLevel = await controller.getZoomLevel() - 0.5;
        controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: centerBounds,
          zoom: zoomLevel,
        )));
        break;
      } else {
        final double zoomLevel = await controller.getZoomLevel() - 0.5;
        controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: centerBounds,
          zoom: zoomLevel,
        )));
      }
    }
  }

  bool fits(LatLngBounds fitBounds, LatLngBounds screenBounds) {
    final bool northEastLatitudeCheck =
        screenBounds.northeast.latitude >= fitBounds.northeast.latitude;
    final bool northEastLongitudeCheck =
        screenBounds.northeast.longitude >= fitBounds.northeast.longitude;

    final bool southWestLatitudeCheck =
        screenBounds.southwest.latitude <= fitBounds.southwest.latitude;
    final bool southWestLongitudeCheck =
        screenBounds.southwest.longitude <= fitBounds.southwest.longitude;

    return northEastLatitudeCheck &&
        northEastLongitudeCheck &&
        southWestLatitudeCheck &&
        southWestLongitudeCheck;
  }

  void timer() async {
    String url;
    final int targetWidth = 120;

    loginController.imgperfil.value == ""
        ? url = 'https://assistesaude.com.br/dist/img/user.png'
        : url =
            'https://assistesaude.com.br/downloads/fotosprofissionais/${loginController.imgperfil.value}';

    final File markerImageFile = await DefaultCacheManager().getSingleFile(url);
    final Uint8List markerImageBytes = await markerImageFile.readAsBytes();

    final Codec markerImageCodec = await instantiateImageCodec(
      markerImageBytes,
      targetWidth: targetWidth,
    );

    final FrameInfo frameInfo = await markerImageCodec.getNextFrame();
    final ByteData? byteData = await frameInfo.image.toByteData(
      format: ImageByteFormat.png,
    );
    final Uint8List resizedMarkerImageBytes = byteData!.buffer.asUint8List();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    LatLng latLatAtual = LatLng(position.latitude, position.longitude);
    // create the instance of CachedNetworkMarker

    Future.delayed(Duration(seconds: 2)).then((_) async {
      if (this.mounted) {
        // check whether the state object is in tree
        setState(() {
          mapaAgendaController.markers.add(Marker(
            markerId: MarkerId('Estou Aqui!'),
            position: latLatAtual,
            infoWindow: InfoWindow(
                title: 'Minha Localização', snippet: "" //"$position",
                ),
            icon: BitmapDescriptor.fromBytes(resizedMarkerImageBytes),
          ));
        });
      }

      timer();
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<String> getJsonFile(String path) async {
      return await rootBundle.loadString(path);
    }

    void setMapStyle(String mapStyle) async {
      final GoogleMapController controller = await _controller.future;
      controller.setMapStyle(mapStyle);
    }

    changeMapMode() {
      getJsonFile("images/mapa_style.json").then(setMapStyle);
    }

    Widget buildGoogleMap(BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
          mapType: MapType.normal,
          zoomControlsEnabled: false,
          zoomGesturesEnabled: true,
          scrollGesturesEnabled: true,
          compassEnabled: true,
          rotateGesturesEnabled: true,
          mapToolbarEnabled: true,
          tiltGesturesEnabled: true,
          initialCameraPosition: CameraPosition(
            target: LatLng(
              mapaAgendaController.lat.value,
              mapaAgendaController.lng.value,
            ),
            zoom: 12,
          ),
          onMapCreated: (GoogleMapController controller) async {
            if (!_controller.isCompleted) {
              _controller.complete(controller);
            } else {}

            changeMapMode();

            Position position = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high);

            LatLng latLatPosition =
                LatLng(position.latitude, position.longitude);

            LatLng latLatCliente = LatLng(
                mapaAgendaController.lat.value, mapaAgendaController.lng.value);

            //condição para o reposicionamemto
            if (latLatPosition.latitude <= latLatCliente.latitude) {
              LatLngBounds bounds = LatLngBounds(
                southwest: latLatPosition,
                northeast: latLatCliente,
              );
              controller
                  .animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
              final LatLng centerBounds = LatLng(
                  (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
                  (bounds.northeast.longitude + bounds.southwest.longitude) /
                      2);

              controller
                  .moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
                target: centerBounds,
                zoom: 16,
              )));
              zoomToFit(controller, bounds, centerBounds);
            } else {
              LatLngBounds bounds = LatLngBounds(
                southwest: latLatCliente,
                northeast: latLatPosition,
              );
              controller
                  .animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
              final LatLng centerBounds = LatLng(
                  (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
                  (bounds.northeast.longitude + bounds.southwest.longitude) /
                      2);

              controller
                  .moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
                target: centerBounds,
                zoom: 16,
              )));
              zoomToFit(controller, bounds, centerBounds);
            }
            // create the instance of CachedNetworkMarker
            final generator = CachedNetworkMarker(
              url: loginController.imgperfil.value == ""
                  ? 'https://assistesaude.com.br/dist/img/user.png'
                  : 'https://assistesaude.com.br/downloads/fotosprofissionais/${loginController.imgperfil.value}',
              // dpr: loginController.deviceRadio.value,
              dpr: 90,
            );

            final bitmap = await generator
                .circleAvatar(CircleAvatarParams(color: Colors.lightBlue));

            if (this.mounted) {
              mapaAgendaController.ourLat.value = position.latitude;
              mapaAgendaController.ourLng.value = position.longitude;
              setState(
                () {
                  mapaAgendaController.markers.add(Marker(
                    markerId: MarkerId('Estou Aqui!'),
                    position: latLatPosition,
                    infoWindow: InfoWindow(
                        title: 'Minha Localização', snippet: "" //"$position",
                        ),
                    icon: BitmapDescriptor.fromBytes(bitmap),
                  ));

                  print('markers ${mapaAgendaController.markers}');
                },
              );
            }
            timer();
          },
          circles: Set.from([
            Circle(
              circleId: CircleId('circle'),
              center: LatLng(mapaAgendaController.lat.value,
                  mapaAgendaController.lng.value),
              radius: 80,
              strokeColor: mapaAgendaController.ctlcheckin.value == '0'
                  ? Colors.yellow.withOpacity(0.2)
                  : Colors.red.withOpacity(0.2),
              fillColor: mapaAgendaController.ctlcheckin.value == '0'
                  ? Colors.yellow.withOpacity(0.3)
                  : Colors.red.withOpacity(0.3),
            )
          ]),
          markers: mapaAgendaController.markers,
        ),
      );
    }

    Widget boxes() {
      return Container(
        child: FloatingActionButton(
          shape: CircleBorder(
            side: BorderSide(
              color: Colors.white,
              width: 4.0,
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            gotoLocation();
          },
          child: Container(
            child: Container(
              padding: const EdgeInsets.all(5),
              child: Icon(
                Icons.my_location_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }

    Widget buildContainer() {
      return Positioned(
        top: 0,
        right: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: boxes(),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mapa Agenda',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Theme.of(context).textSelectionTheme.selectionColor,
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                calendarioController.agenda().then((value) => value);
                Get.offAllNamed('/home');
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      floatingActionButton: mapaAgendaController.ctlcheckin.value == '0'
          ? SpeedDial(
              icon: Icons.add,
              iconTheme: IconThemeData(color: Colors.white),
              activeIcon: Icons.close,
              visible: true,
              closeManually: false,
              renderOverlay: false,
              backgroundColor: Theme.of(context).primaryColor,
              curve: Curves.elasticInOut,
              overlayColor: Colors.black,
              overlayOpacity: 0.5,
              shape: CircleBorder(
                side: BorderSide(
                  color: Colors.white,
                  width: 4.0,
                ),
              ),
              elevation: 5,
              children: [
                SpeedDialChild(
                  labelBackgroundColor:
                      Theme.of(context).textSelectionTheme.selectionColor,
                  child: Icon(
                    Icons.check,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                  ),
                  backgroundColor: Colors.green,
                  label: 'Check-in',
                  labelStyle: GoogleFonts.montserrat(
                      fontSize: 14, color: Theme.of(context).accentColor),
                  onTap: () {
                    deleteAlert(
                      context,
                      'Deseja fazer check-in?',
                      () async {
                        await mapaAgendaController.doCheckIn(context);
                      },
                    );
                  },
                ),
                SpeedDialChild(
                  labelBackgroundColor:
                      Theme.of(context).textSelectionTheme.selectionColor,
                  child: Icon(
                    Icons.schedule,
                    color: Theme.of(context).accentColor,
                  ),
                  backgroundColor: Colors.greenAccent,
                  label: 'Horário',
                  labelStyle: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Theme.of(context).accentColor,
                  ),
                  onTap: () {
                    Get.toNamed('/agendarhorario');
                  },
                ),
                SpeedDialChild(
                  labelBackgroundColor:
                      Theme.of(context).textSelectionTheme.selectionColor,
                  child: Icon(
                    Icons.info,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                  ),
                  backgroundColor: Colors.grey,
                  label: 'Info check',
                  labelStyle: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Theme.of(context).accentColor,
                  ),
                  onTap: () {
                    Get.toNamed('/infoCheck');
                  },
                ),
                SpeedDialChild(
                  labelBackgroundColor:
                      Theme.of(context).textSelectionTheme.selectionColor,
                  child: Icon(
                    Icons.replay_outlined,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                  ),
                  backgroundColor: Colors.amber[800],
                  label: 'Atualizar GPS',
                  labelStyle: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Theme.of(context).accentColor,
                  ),
                  onTap: () {
                    deleteAlert(context, "Deseja atualizar o GPS?", () async {
                      await mapaAgendaController.doChangeGps(context);
                    });
                  },
                ),
                SpeedDialChild(
                  labelBackgroundColor:
                      Theme.of(context).textSelectionTheme.selectionColor,
                  child: Icon(
                    Icons.delete,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                  ),
                  backgroundColor: Colors.red,
                  label: 'Deletar',
                  labelStyle: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Theme.of(context).accentColor,
                  ),
                  onTap: () {
                    deleteAlert(context, "Deseja deletar a sessão?", () async {
                      await mapaAgendaController.deleteClient(context);
                    });
                  },
                ),
              ],
            )
          : SpeedDial(
              icon: Icons.add,
              iconTheme: IconThemeData(color: Colors.white),
              activeIcon: Icons.close,
              visible: true,
              closeManually: false,
              renderOverlay: false,
              backgroundColor: Theme.of(context).primaryColor,
              curve: Curves.elasticInOut,
              overlayColor: Colors.black,
              overlayOpacity: 0.5,
              shape: CircleBorder(
                side: BorderSide(
                  color: Colors.white,
                  width: 4.0,
                ),
              ),
              elevation: 5,
              children: [
                SpeedDialChild(
                  labelBackgroundColor:
                      Theme.of(context).textSelectionTheme.selectionColor,
                  child: Icon(
                    Icons.check,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                  ),
                  backgroundColor: Colors.red,
                  label: 'Check-out',
                  labelStyle: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Theme.of(context).accentColor,
                  ),
                  onTap: () {
                    deleteAlert(
                      context,
                      'Deseja fazer check-out?',
                      () async {
                        await mapaAgendaController.doCheckout(context);
                      },
                    );
                  },
                ),
                SpeedDialChild(
                  labelBackgroundColor:
                      Theme.of(context).textSelectionTheme.selectionColor,
                  child: Icon(
                    Icons.info_outline,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                  ),
                  backgroundColor: Colors.grey,
                  label: 'Info check',
                  labelStyle: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Theme.of(context).accentColor,
                  ),
                  onTap: () {
                    Get.toNamed('/infoCheck');
                  },
                ),
              ],
            ),
      body: Obx(
        () {
          return mapaAgendaController.isLoading.value
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black,
                  child: Center(
                    child: SizedBox(
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                        valueColor: AlwaysStoppedAnimation(Colors.red[900]),
                      ),
                      height: 40,
                      width: 40,
                    ),
                  ),
                )
              : Stack(
                  children: [
                    buildGoogleMap(context),
                    buildContainer(),
                  ],
                );
        },
      ),
    );
  }
}
