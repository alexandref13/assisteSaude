import 'dart:convert';
import 'dart:io';
import 'package:assistsaude/modules/Login/login_repository.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var email = TextEditingController().obs;
  var password = TextEditingController().obs;
  var isLoading = false.obs;
  var idprof = ''.obs;
  var nome = ''.obs;
  var sobrenome = ''.obs;
  var tipousu = ''.obs;
  var imgperfil = ''.obs;
  var especialidade = ''.obs;
  var deviceId = '';

  final formKey = GlobalKey<FormState>();

  login() async {
    isLoading(true);

    final response = await LoginRepository.login();

    var dadosUsuario = json.decode(response.body);

    isLoading(false);

    print(dadosUsuario);

    if (dadosUsuario['valida'] == 1) {
      idprof.value = dadosUsuario['idprof'];
      nome.value = dadosUsuario['nome'];
      sobrenome.value = dadosUsuario['sobrenome'];
      tipousu.value = dadosUsuario['tipousu'];
      imgperfil.value = dadosUsuario['imgperfil'];
      especialidade.value = dadosUsuario['especialidade'];

      Get.offNamed('/home');
    } else {
      password.value.text = '';
    }
  }

  Future<String> getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor;
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId;
    }
  }

  @override
  void onInit() async {
    deviceId = await getId();
    super.onInit();
  }
}
