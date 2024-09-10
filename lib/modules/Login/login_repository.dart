import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'login_controller.dart';
import 'dart:async';

class LoginRepository {
  static Future login() async {
    LoginController loginController = Get.find(tag: 'login');

    return await http.post(
      Uri.https("assistesaude.com.br", "/flutter/login.php"),
      body: {
        'email': loginController.email.value.text,
        'senha': loginController.password.value.text,
        'idevice': loginController.deviceId,
      },
    );
  }

  // ignore: non_constant_identifier_names
  static Future Newlogin(String? id) async {
    LoginController loginController = Get.find(tag: 'login');

    return await http.post(
      Uri.https("assistesaude.com.br", "/flutter/dados_prof.php"),
      body: {
        'idprof': id,
        'idevice': loginController.deviceId,
      },
    );
  }

  static Future hasMoreEmail(String? email) async {
    return await http.post(
      Uri.https("assistesaude.com.br", "/flutter/clientes_lista.php"),
      body: {
        'email': email,
      },
    );
  }
}
