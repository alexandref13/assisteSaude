import 'dart:convert';
import 'package:assistsaude/shared/alert_button_pressed.dart';
import 'package:assistsaude/shared/confirmed_button_pressed.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../mapa_agenda_controller.dart';
import 'info_check_repository.dart';

class InfoCheckController extends GetxController {
  MapaAgendaController mapaAgendaController = Get.put(MapaAgendaController());
  var isLoading = false.obs;
  var idvisita = ''.obs;
  var hour = TextEditingController().obs;

  var maskHour = new MaskTextInputFormatter(
    mask: '##:##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  changeHours(context) async {
    isLoading(true);

    final response = await InfoCheckRepository.changeHours();

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
      confirmedButtonPressed(
        context,
        mapaAgendaController.ctlcheckin.value == '0'
            ? 'Info check-in realizado com sucesso!'
            : 'Info check-out realizado com sucesso!',
        () {
          Get.offAllNamed('/home');
        },
      );
    }

    isLoading(false);
  }
}
