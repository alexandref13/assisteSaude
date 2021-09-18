import 'dart:convert';
import 'package:assistsaude/modules/AgendarHorario/agendar_repository.dart';
import 'package:assistsaude/shared/confirmed_button_pressed.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AgendaHorarioController extends GetxController {
  var isLoading = false.obs;
  var idvisita = ''.obs;
  var hour = TextEditingController().obs;

  var horaMaskFormatter = new MaskTextInputFormatter(
    mask: '##:##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  changeHours(context) async {
    isLoading(true);

    final response = await AgendarRepository.changeHours();

    var dados = json.decode(response.body);

    if (dados['valida'] == 0) {
      onAlertButtonPressed(
          context, 'Algo deu errado, tente novamente', '/home');
    } else {
      confirmedButtonPressed(context, 'Horário incluído com sucesso!', () {
        Get.offAllNamed('/home');
      });
    }

    isLoading(false);
  }

  void onAlertButtonPressed(context, String s, String t) {}
}
