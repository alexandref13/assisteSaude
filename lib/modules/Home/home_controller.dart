import 'package:assistsaude/modules/Login/login_controller.dart';
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

    Get.offAllNamed('/login');
  }

  abrirWhatsApp() async {
    var whatsappUrl =
        "whatsapp://send?phone=+5591981220670&text=Olá, preciso de ajuda";

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }
}
