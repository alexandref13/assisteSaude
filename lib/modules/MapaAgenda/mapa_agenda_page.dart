import 'dart:async';

import 'package:assistsaude/modules/Agenda/calendario_controller.dart';
import 'package:assistsaude/modules/Login/login_controller.dart';
import 'package:assistsaude/modules/MapaAgenda/components/widgets/boxes_prof_widget.dart';
import 'package:assistsaude/modules/MapaAgenda/components/widgets/boxes_widgets.dart';
import 'package:assistsaude/modules/MapaAgenda/components/widgets/count_time_widget.dart';
import 'package:assistsaude/modules/MapaAgenda/mapa_agenda_controller.dart';
import 'package:assistsaude/shared/delete_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safe_device/safe_device.dart';

class MapaAgendaPage extends StatefulWidget {
  const MapaAgendaPage({Key? key}) : super(key: key);

  @override
  _MapaAgendaPageState createState() => _MapaAgendaPageState();
}

class _MapaAgendaPageState extends State<MapaAgendaPage> {
  CalendarioController calendarioController = Get.put(CalendarioController());
  LoginController loginController = Get.find(tag: 'login');
  final MapaAgendaController mapaAgendaController =
      Get.put(MapaAgendaController());
  Completer<GoogleMapController> _controller = Completer();

  BitmapDescriptor markerProf = BitmapDescriptor.defaultMarker;
  BitmapDescriptor markerPac = BitmapDescriptor.defaultMarker;

  // Position? _position;

  bool isJailBroken = false;
  bool canMockLocation = false;
  bool isRealDevice = true;
  bool isOnExternalStorage = false;
  bool isSafeDevice = false;
  bool isDevelopmentModeEnable = false;

  @override
  void initState() {
    initPlatformState();
    _determinePosition();

    super.initState();
  }

  Future<void> initPlatformState() async {
    await Permission.location.request();
    if (await Permission.location.isPermanentlyDenied) {
      openAppSettings();
    }

    if (!mounted) return;
    try {
      isJailBroken = await SafeDevice.isJailBroken;
      canMockLocation = await SafeDevice.canMockLocation;
      isRealDevice = await SafeDevice.isRealDevice;
      isOnExternalStorage = await SafeDevice.isOnExternalStorage;
      isSafeDevice = await SafeDevice.isSafeDevice;
      isDevelopmentModeEnable = await SafeDevice.isDevelopmentModeEnable;
    } catch (error) {
      print(error);
    }

    setState(() {
      isJailBroken = isJailBroken;
      canMockLocation = canMockLocation;
      isRealDevice = isRealDevice;
      isOnExternalStorage = isOnExternalStorage;
      isSafeDevice = isSafeDevice;
      isDevelopmentModeEnable = isDevelopmentModeEnable;
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Serviços de localização desabilitados!');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Permissão de localização negada!');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'As permissões de localização estão permanentemente negadas!');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
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

  // void timer() async {
  //   Position position = await _determinePosition();
  //   setState(() {
  //     _position = position;
  //   });

  //   LatLng latLatAtual = LatLng(position.latitude, position.longitude);
  //   // create the instance of CachedNetworkMarker

  //   TargetPlatform _platform = Theme.of(context).platform;
  //   BitmapDescriptor markerbitmapprof = await BitmapDescriptor.fromAssetImage(
  //     ImageConfiguration(),
  //     _platform == TargetPlatform.iOS
  //         ? "images/profissional.png"
  //         : "images/profissional_android.png",
  //   );

  //   Future.delayed(Duration(seconds: 2)).then((_) async {
  //     if (this.mounted) {
  //       setState(() {
  //         mapaAgendaController.ourLat.value = position.latitude;
  //         mapaAgendaController.ourLng.value = position.longitude;
  //         mapaAgendaController.markers.add(Marker(
  //           markerId: MarkerId('Estou Aqui!'),
  //           position: latLatAtual,
  //           infoWindow: InfoWindow(
  //               title: 'Sua localização atual', snippet: "" //"$position",
  //               ),
  //           icon: markerbitmapprof,
  //         ));
  //       });
  //     }
  //     timer();
  //   });
  // }

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

  @override
  Widget build(BuildContext context) {
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

    Future<void> gotoLocationProf() async {
      final GoogleMapController controller = await _controller.future;
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 18,
        tilt: 20,
        bearing: 45,
      )));
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
                    Icons.check_circle_outline,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                  ),
                  backgroundColor: Colors.green,
                  label: 'Check-in',
                  labelStyle: GoogleFonts.montserrat(
                      fontSize: 14, color: Theme.of(context).hintColor),
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
                    color: Theme.of(context).hintColor,
                  ),
                  backgroundColor: Colors.greenAccent,
                  label: 'Horário',
                  labelStyle: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                  ),
                  onTap: () {
                    Get.toNamed('/agendarhorario');
                  },
                ),
                SpeedDialChild(
                  labelBackgroundColor:
                      Theme.of(context).textSelectionTheme.selectionColor,
                  child: Icon(
                    Icons.info_outline_rounded,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                  ),
                  backgroundColor: Colors.grey,
                  label: 'Info check',
                  labelStyle: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
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
                    color: Theme.of(context).hintColor,
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
                    Icons.delete_outline,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                  ),
                  backgroundColor: Colors.red,
                  label: 'Deletar',
                  labelStyle: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
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
                    color: Theme.of(context).hintColor,
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
                    color: Theme.of(context).hintColor,
                  ),
                  onTap: () {
                    Get.toNamed('/infoCheck');
                  },
                ),
                SpeedDialChild(
                  labelBackgroundColor:
                      Theme.of(context).textSelectionTheme.selectionColor,
                  child: Icon(
                    Icons.restore,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                  ),
                  backgroundColor: Colors.blueAccent,
                  label: 'Resetar',
                  labelStyle: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                  ),
                  onTap: () {
                    deleteAlert(
                      context,
                      'Deseja resetar esta sessão?',
                      () async {
                        await mapaAgendaController.doResetar(context);
                      },
                    );
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
                    Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: StreamBuilder<Position>(
                          stream: Geolocator.getPositionStream(),
                          builder: (context, snapshot) {
                            final position = snapshot.data;

                            mapaAgendaController.ourLat.value =
                                position?.latitude ?? 0.0;
                            mapaAgendaController.ourLng.value =
                                position?.longitude ?? 0.0;

                            if (snapshot.connectionState ==
                                    ConnectionState.waiting ||
                                position == null) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            return GoogleMap(
                              mapType: MapType.normal,
                              zoomControlsEnabled: true,
                              zoomGesturesEnabled: true,
                              scrollGesturesEnabled: true,
                              compassEnabled: true,
                              rotateGesturesEnabled: true,
                              mapToolbarEnabled: true,
                              tiltGesturesEnabled: true,
                              myLocationButtonEnabled: false,

                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                  position.latitude,
                                  position.longitude,
                                ),
                                zoom: 12,
                              ),
                              onMapCreated: ((controller) async {
                                if (!_controller.isCompleted) {
                                  _controller.complete(controller);
                                }

                                changeMapMode();

                                // NOTE -> Aqui eu estou iniciando os Markers tanto do profissional quanto do paciente

                                TargetPlatform _platform =
                                    Theme.of(context).platform;

                                markerProf =
                                    await BitmapDescriptor.fromAssetImage(
                                  ImageConfiguration(),
                                  _platform == TargetPlatform.iOS
                                      ? "images/profissional.png"
                                      : "images/profissional_android.png",
                                );

                                markerPac =
                                    await BitmapDescriptor.fromAssetImage(
                                  ImageConfiguration(),
                                  _platform == TargetPlatform.iOS
                                      ? "images/paciente.png"
                                      : "images/paciente_android.png",
                                );

                                LatLng latLatPosition = LatLng(
                                  position.latitude,
                                  position.longitude,
                                );

                                LatLng latLatCliente = LatLng(
                                  mapaAgendaController.lat.value,
                                  mapaAgendaController.lng.value,
                                );

                                //condição para o reposicionamemto
                                if (latLatPosition.latitude <=
                                    latLatCliente.latitude) {
                                  LatLngBounds bounds = LatLngBounds(
                                    southwest: latLatPosition,
                                    northeast: latLatCliente,
                                  );

                                  controller.animateCamera(
                                      CameraUpdate.newLatLngBounds(bounds, 50));
                                  final LatLng centerBounds = LatLng(
                                      (bounds.northeast.latitude +
                                              bounds.southwest.latitude) /
                                          2,
                                      (bounds.northeast.longitude +
                                              bounds.southwest.longitude) /
                                          2);

                                  controller.moveCamera(
                                      CameraUpdate.newCameraPosition(
                                          CameraPosition(
                                    target: centerBounds,
                                    zoom: 16,
                                  )));

                                  zoomToFit(controller, bounds, centerBounds);
                                } else {
                                  LatLngBounds bounds = LatLngBounds(
                                    southwest: latLatCliente,
                                    northeast: latLatPosition,
                                  );
                                  controller.animateCamera(
                                      CameraUpdate.newLatLngBounds(bounds, 50));
                                  final LatLng centerBounds = LatLng(
                                      (bounds.northeast.latitude +
                                              bounds.southwest.latitude) /
                                          2,
                                      (bounds.northeast.longitude +
                                              bounds.southwest.longitude) /
                                          2);

                                  controller.moveCamera(
                                      CameraUpdate.newCameraPosition(
                                          CameraPosition(
                                    target: centerBounds,
                                    zoom: 16,
                                  )));

                                  zoomToFit(controller, bounds, centerBounds);
                                }

                                canMockLocation
                                    ? await mapaAgendaController.VerGps(context)
                                    : print('TUDO CERTO COM GPS');

                                setState(() {});
                              }),
                              // onMapCreated:
                              //     (GoogleMapController controller) async {
                              //   if (!_controller.isCompleted) {
                              //     _controller.complete(controller);
                              //   } else {}

                              //   setState(() {

                              //   // timer();
                              // },
                              circles: Set.from([
                                Circle(
                                  circleId: CircleId('circle'),
                                  center: LatLng(
                                    mapaAgendaController.lat.value,
                                    mapaAgendaController.lng.value,
                                  ),
                                  radius: 80,
                                  strokeColor:
                                      mapaAgendaController.ctlcheckin.value ==
                                              '0'
                                          ? Colors.yellow.withOpacity(0.2)
                                          : Colors.red.withOpacity(0.2),
                                  fillColor:
                                      mapaAgendaController.ctlcheckin.value ==
                                              '0'
                                          ? Colors.yellow.withOpacity(0.3)
                                          : Colors.red.withOpacity(0.3),
                                )
                              ]),
                              markers: Set<Marker>.from([
                                Marker(
                                  markerId: MarkerId('Estou Aqui!'),
                                  position: LatLng(
                                    position.latitude,
                                    position.longitude,
                                  ),
                                  infoWindow: InfoWindow(
                                      title: 'Sua localização atual',
                                      snippet: "" //"$position",
                                      ),
                                  icon: markerProf,
                                ),
                                Marker(
                                  markerId:
                                      MarkerId(mapaAgendaController.name.value),
                                  position: LatLng(
                                    mapaAgendaController.lat.value,
                                    mapaAgendaController.lng.value,
                                  ),
                                  infoWindow: InfoWindow(
                                    title: mapaAgendaController.name.value,
                                    snippet: mapaAgendaController
                                                .ctlcheckin.value ==
                                            '0'
                                        ? "${mapaAgendaController.adress}"
                                        : "${mapaAgendaController.adress}\nCheck-in:${mapaAgendaController.checkin.value}",
                                  ),
                                  icon: markerPac,
                                ),
                              ]),
                            );
                          },
                        )),
                    Stack(
                      //alignment: Alignment.bottomRight,
                      // textDirection: TextDirection.ltr,
                      children: [
                        BoxesWidget(
                          onTap: gotoLocation,
                        ),
                        BoxesProfWidget(
                          onTap: gotoLocationProf,
                        )
                      ],
                    ),
                    mapaAgendaController.checkin.value == "30/11/-1 00:00"
                        ? SizedBox.shrink()
                        : CountTimeWidget(
                            checkIn: mapaAgendaController.checkin.value,
                          )
                  ],
                );
        },
      ),
    );
  }
}
