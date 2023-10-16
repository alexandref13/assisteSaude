import 'dart:convert';
import 'package:assistsaude/modules/Login/login_controller.dart';
import 'package:assistsaude/modules/MapaAgenda/mapa_agenda_repository.dart';
import 'package:assistsaude/shared/alert_button_pressed.dart';
import 'package:assistsaude/shared/confirmed_button_pressed.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io' show Platform;

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
  var ctlcheckout = ''.obs;
  var infocheckin = ''.obs;
  var infocheckout = ''.obs;
  var dtagenda = ''.obs;
  var idSessao = ''.obs;
  var idPaciente = ''.obs;
  var checkin = ''.obs;
  var checkout = ''.obs;
  var obs = ''.obs;
  var evolcao = ''.obs;
  var observacao = TextEditingController().obs;
  var evolucao = TextEditingController().obs;

  var markers = <Marker>{}.obs;

  getClientes() async {
    final MapaAgendaController mapaAgendaController =
        Get.put(MapaAgendaController());

    BitmapDescriptor markerbitmap;

// Verificar se a plataforma é Android e definir o tamanho do marcador como 180px
    if (Platform.isAndroid) {
      markerbitmap = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(),
        "images/paciente_android.png",
      );
    } else {
      markerbitmap = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(),
        "images/paciente.png",
      );
    }
    markers.assign(
      Marker(
        markerId: MarkerId(name.value),
        position: LatLng(lat.value, lng.value),
        infoWindow: InfoWindow(
          title: name.value,
          snippet: mapaAgendaController.ctlcheckin.value == '0'
              ? "$adress"
              : "$adress\nCheck-in:${mapaAgendaController.checkin.value}",
        ),
        icon: markerbitmap,
      ),
    );
    isLoading(false);
  }

  doObs(context) async {
    final response = await MapaAgendaRepository.doObs();

    var dados = json.decode(response.body);

    if (dados == 1) {
      confirmedButtonPressed(context, 'Observação Salva com Sucesso!', () {
        Get.offAllNamed('/home');
      });
    } else {
      onAlertButtonPressed(
        context,
        'Houve Algum Problema! Tente Novamente',
        () {
          Get.back();
        },
      );
    }
  }

  doEvolucao(context) async {
    final response = await MapaAgendaRepository.doEvolucao();

    var dados = json.decode(response.body);

    isLoading = false.obs;

    if (dados == 1) {
      confirmedButtonPressed(context, 'Evolução Salva com Sucesso!', () {
        Get.offAllNamed('/home');
      });
    } else {
      onAlertButtonPressed(
        context,
        'Houve Algum Problema! Tente Novamente',
        () {
          Get.back();
        },
      );
    }
  }

  VerGps(context) async {
    final response = await MapaAgendaRepository.verGps();

    var dados = json.decode(response.body);

    if (dados == 1) {
      confirmedButtonPressed(context, 'Detecção de GPS negada! Tente novamente',
          () {
        Get.offAllNamed('/home');
      });
    } else {
      return false;
    }
  }

  doCheckIn(context) async {
    final response = await MapaAgendaRepository.doCheckin();

    var dados = json.decode(response.body);

    loginController.selectedIndex.value = 3;

    if (dados['valida'] == 0) {
      onAlertButtonPressed(
        context,
        'Local fora do raio\npermitido para ação!',
        () {
          Get.offAllNamed('/home');
        },
      );
    } else if (dados['valida'] == 1) {
      confirmedButtonPressed(context, 'Check-in realizado com sucesso!', () {
        Get.offAllNamed('/home');
      });
    } else if (dados['valida'] == 3) {
      onAlertButtonPressed(
          context, 'Existe uma sessão em andamento! Finalize para continuar.',
          () {
        Get.offAllNamed('/home');
      });
    } else {
      onAlertButtonPressed(
        context,
        'Houve algum problema! Tente Novamente',
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
        'Local fora do raio\npermitido para ação!',
        () {
          Get.offAllNamed('/home');
        },
      );
    } else if (dados['valida'] == 1) {
      confirmedButtonPressed(context, 'Check-out realizado com sucesso!', () {
        Get.offAllNamed('/home');
      });
    } else {
      onAlertButtonPressed(
        context,
        'Houve algum problema! Tente Novamente',
        () {
          Get.offAllNamed('/home');
        },
      );
    }
  }

  doResetar(context) async {
    final response = await MapaAgendaRepository.doReset();

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
      confirmedButtonPressed(context, 'Reset realizado com sucesso!', () {
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

      //Solicitação desta sessão já enviada anteriormente! Aguarde o aceite da administração.
    } else if (dados['valida'] == 2) {
      onAlertButtonPressed(
          context, 'Solicitação já enviada!\nAguarde retorno da administração.',
          () {
        Get.offAllNamed('/home');
      });
    } else if (dados['valida'] == 1) {
      confirmedButtonPressed(context, 'Alteração de GPS realizado com sucesso!',
          () {
        Get.offAllNamed('/home');
      });
    } else {
      confirmedButtonPressed(context,
          'Solicitação enviada com sucesso!\nAguarde o retorno da avaliação da administração.',
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
