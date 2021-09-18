import 'package:assistsaude/modules/Login/login_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiCalendario {
  static Future getCalendario() async {
    LoginController loginController = Get.find(tag: 'login');

    print({
      loginController.idprof.value,
    });

    return await http.post(
      Uri.https("assistesaude.com.br", "flutter/sessoes_agenda.php"),
      body: {
        'idprof': loginController.idprof.value,
      },
    );
  }
}
