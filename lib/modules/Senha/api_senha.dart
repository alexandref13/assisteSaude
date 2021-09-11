import 'package:assistsaude/modules/Login/login_controller.dart';
import 'package:assistsaude/modules/Senha/senha_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiSenha {
  static Future senha() async {
    LoginController loginController = Get.put(LoginController());
    SenhaController senhaController = Get.put(SenhaController());

    return await http.post(
      Uri.https(
          "www.admautopecasbelem.com.br", "/login/flutter/senha_alterar.php"),
      body: {
        // 'idusu': loginController.idusu.value,
        // 'senha': senhaController.senhanova.value.text,
      },
    );
  }
}
