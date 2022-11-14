import 'dart:io';

import 'package:assistsaude/modules/Login/login_controller.dart';
import 'package:assistsaude/shared/alert_button_pressed.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  LoginController loginController = Get.find(tag: 'login');

  final GlobalKey<ScaffoldState> key = GlobalKey();

  Future<void> logoutUser() async {
    await GetStorage.init();

    final box = GetStorage();
    box.erase();

    loginController.email.value.text = '';
    loginController.password.value.text = '';
    loginController.nome.value = '';
    loginController.tipousu.value = '';
    loginController.idCliente.value = '';

    Get.offAllNamed('/login');
  }

  abrirWhatsApp(String cel, context) async {
    var celular = cel
        .replaceAll("(", "")
        .replaceAll(")", "")
        .replaceAll("-", "")
        .replaceAll(" ", "");
    // add the [https]

    String url() {
      if (Platform.isAndroid) {
        // add the [https]
        return "whatsapp://send?phone=$celular"; // new line
      } else {
        // add the [https]
        return "https://wa.me/$celular"; // new line
      }
    }
//var whatsappUrl = "whatsapp://send?phone=$celular";

    await canLaunch(
      url(),
    )
        ? launch(url(), forceSafariVC: false)
        : onAlertButtonPressed(
            context, 'Erro! Não foi possível ir para o whatsapp.', () {
            Get.back();
          });
  } // new line
}
