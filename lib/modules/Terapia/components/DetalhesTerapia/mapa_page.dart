import 'package:assistsaude/modules/MapaAgenda/mapa_agenda_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';

class MapaPage extends StatefulWidget {
  const MapaPage({Key? key}) : super(key: key);

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final MapaAgendaController mapaAgendaController =
      Get.put(MapaAgendaController());

  Completer<GoogleMapController> _controller = Completer();

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
        final double zoomLevel = await controller.getZoomLevel() - 0.1;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Localização Paciente',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Theme.of(context).textSelectionTheme.selectionColor,
            ),
          ),
          centerTitle: true,
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
                    children: <Widget>[
                      _buildGoogleMap(context),
                      _boxes(),
                    ],
                  );
          },
        ));
  }

  changeMapMode() {
    getJsonFile("images/mapa_style.json").then(setMapStyle);
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void setMapStyle(String mapStyle) async {
    final GoogleMapController controller = await _controller.future;
    controller.setMapStyle(mapStyle);
  }

  /*Widget _buildContainer() {
    return Positioned(
      bottom: 10,
      right: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: _boxes(
                    double.parse(clientesController.lat.value),
                    double.parse(clientesController.lng.value),
                    clientesController.nomecliente.value,
                    clientesController.endereco.value,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }*/

  Widget _boxes() {
    return Positioned(
      bottom: 10,
      right: 10,
      child: FloatingActionButton(
        elevation: 10,
        onPressed: () {
          _gotoLocation(
            mapaAgendaController.lat.value,
            mapaAgendaController.lng.value,
          );
        },
        child: Icon(
          Icons.my_location_outlined,
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        heroTag: 'call',
        shape: CircleBorder(
          side: BorderSide(
            color: Colors.white,
            width: 4.0,
          ),
        ),
        tooltip: 'Call',
      ),
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
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
              target: LatLng(mapaAgendaController.lat.value,
                  mapaAgendaController.lng.value),
              zoom: 14),
          onMapCreated: (GoogleMapController controller) {
            if (!_controller.isCompleted) {
              _controller.complete(controller);
            } else {}
            changeMapMode();
          },
          markers: mapaAgendaController.markers,
        ));
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 16,
      tilt: 40,
      bearing: 40,
    )));
  }
}
