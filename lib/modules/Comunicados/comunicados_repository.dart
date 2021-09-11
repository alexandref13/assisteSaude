import 'package:assistsaude/modules/Login/login_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ComunicadosRepository {
  static Future getComunicados() async {
    LoginController loginController = Get.find(tag: 'login');

    return await http.post(
      Uri.https("admautopecasbelem.com.br", "login/flutter/comunicados.php"),
      body: {
        'idusu': '27',
      },
    );
  }
}
