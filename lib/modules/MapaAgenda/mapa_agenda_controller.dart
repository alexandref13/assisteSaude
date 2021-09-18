import 'dart:convert';
import 'package:assistsaude/modules/Login/login_controller.dart';
import 'package:assistsaude/modules/MapaAgenda/mapa_agenda_repository.dart';
import 'package:assistsaude/shared/alert_button_pressed.dart';
import 'package:assistsaude/shared/confirmed_button_pressed.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaAgendaController extends GetxController {
  LoginController loginController = Get.find(tag: 'login');

  var isLoading = true.obs;
  var lat = 0.0.obs;
  var lng = 0.0.obs;
  var ourLat = 0.0.obs;
  var ourLng = 0.0.obs;
  var name = ''.obs;
  var adress = ''.obs;
  var district = ''.obs;
  var city = ''.obs;
  var uf = ''.obs;
  var number = ''.obs;
  var ctlcheckin = ''.obs;
  var dtagenda = ''.obs;
  var idSessao = ''.obs;
  var idPaciente = ''.obs;
  var checkin = ''.obs;
  var checkout = ''.obs;
  var obs = ''.obs;
  var observacao = TextEditingController().obs;

  var markers = <Marker>{}.obs;

  getClientes() async {
    markers.assign(
      Marker(
        markerId: MarkerId(name.value),
        position: LatLng(lat.value, lng.value),
        infoWindow: InfoWindow(
          title: name.value,
          snippet: "$adress",
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
    );
    isLoading(false);
  }

  doObs(context) async {
    final response = await MapaAgendaRepository.doObs();

    var dados = json.decode(response.body);

    if (dados['valida'] == 1) {
      confirmedButtonPressed(context, 'Observação salva com sucesso!', () {
        Get.offAllNamed('/home');
      });
    } else {
      onAlertButtonPressed(
        context,
        'Houve Algum Problema! Tente Novamente',
        () {
          Get.offAllNamed('/home');
        },
      );
    }
  }

  doCheckIn(context) async {
    final response = await MapaAgendaRepository.doCheckin();

    var dados = json.decode(response.body);

    loginController.selectedIndex.value = 3;

    if (dados['valida'] == 0) {
      onAlertButtonPressed(
        context,
        'Paciente Fora do Raio de Check-in!',
        () {
          Get.offAllNamed('/home');
        },
      );
    } else if (dados['valida'] == 1) {
      confirmedButtonPressed(context, 'Check-in realizado com sucesso!', () {
        Get.offAllNamed('/home');
      });
    } else {
      onAlertButtonPressed(
        context,
        'Houve Algum Problema! Tente Novamente',
        () {
          Get.offAllNamed('/home');
        },
      );
    }
  }

  doCheckout(context) async {
    final response = await MapaAgendaRepository.doCheckin();

    var dados = json.decode(response.body);

    if (dados['valida'] == 0) {
      onAlertButtonPressed(
        context,
        'Algo deu errado, tente novamente',
        () {
          Get.offAllNamed('/home');
        },
      );
    } else {
      confirmedButtonPressed(context, 'Check-out realizado com sucesso!', () {
        Get.offAllNamed('/home');
      });
    }
  }

  doChangeGps(context) async {
    final response = await MapaAgendaRepository.doChangeGps();

    var dados = json.decode(response.body);

    if (dados['valida'] == 0) {
      onAlertButtonPressed(
        context,
        'Algo deu errado, tente novamente',
        () {
          Get.offAllNamed('/home');
        },
      );
    } else {
      confirmedButtonPressed(context, 'Alteração de GPS realizado com sucesso!',
          () {
        Get.offAllNamed('/home');
      });
    }
  }

  deleteClient(context) async {
    final response = await MapaAgendaRepository.deleteClient();

    var dados = json.decode(response.body);

    loginController.selectedIndex.value = 3;

    if (dados['valida'] == 0) {
      onAlertButtonPressed(
        context,
        'Algo deu errado, tente novamente',
        () {
          Get.offAllNamed('/home');
        },
      );
    } else {
      confirmedButtonPressed(context, 'Sessão Deletada com Sucesso!', () {
        Get.offAllNamed('/home');
      });
    }
  }
}
