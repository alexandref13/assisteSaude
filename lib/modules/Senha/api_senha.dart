import 'package:assistsaude/modules/Login/login_controller.dart';
import 'package:assistsaude/modules/Senha/senha_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiSenha {
  static Future senha() async {
    LoginController loginController = Get.find(tag: 'login');
    SenhaController senhaController = Get.put(SenhaController());

    return await http.post(
      Uri.https("assistesaude.com.br", "flutter/senha_alterar.php"),
      body: {
        'idprof': loginController.idprof.value,
        'senha': senhaController.senhanova.value.text,
      },
    );
  }
}
