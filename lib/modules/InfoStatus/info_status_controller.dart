import 'dart:convert';
import 'package:assistsaude/modules/InfoStatus/info_status_repository.dart';
import 'package:assistsaude/modules/Login/login_controller.dart';
import 'package:assistsaude/modules/Terapia/terapia_controller.dart';
import 'package:assistsaude/shared/alert_button_pressed.dart';
import 'package:assistsaude/shared/confirmed_button_pressed.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class InfoStatusController extends GetxController {
  TerapiaController terapiaController = Get.put(TerapiaController());
  LoginController loginController = Get.find(tag: 'login');

  var status = [].obs;
  var firstId = '0'.obs;
  var observation = TextEditingController().obs;
  var isLoading = false.obs;

  getStatus() async {
    isLoading(true);

    final response = await InfoStatusRepository.getStatus();

    var dados = json.decode(response.body);

    status.assignAll(dados);

    isLoading(false);
  }

  doInfoStatus(context) async {
    isLoading(true);

    final response = await InfoStatusRepository.doInfoStatus();

    var dados = json.decode(response.body);

    print(dados);

    if (dados == 1) {
      confirmedButtonPressed(
        context,
        'Informação de status enviada com sucesso!\nAguarde confirmação da administração',
        () {
          terapiaController.getTerapias();

          loginController.selectedIndex.value = 2;

          Get.offAllNamed('/home');
        },
      );
    } else {
      onAlertButtonPressed(
        context,
        'Algo deu errado',
        () {
          Get.offAllNamed('/home');
        },
      );
    }

    isLoading(false);
  }

  @override
  void onInit() {
    getStatus();
    super.onInit();
  }
}
