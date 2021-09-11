import 'package:assistsaude/modules/Login/login_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ComunicadosRepository {
  static Future getComunicados() async {
    LoginController loginController = Get.find(tag: 'login');

    return await http.post(
      Uri.https("assistesaude.com.br", "flutter/comunicados.php"),
      body: {
        'idcliente': loginController.idCliente.value,
      },
    );
  }
}
