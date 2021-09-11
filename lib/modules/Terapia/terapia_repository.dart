import 'package:assistsaude/modules/Login/login_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TerapiaRepository {
  static Future getTerapias() async {
    LoginController loginController = Get.find(tag: 'login');

    print(loginController.idprof.value);

    return await http.post(
      Uri.https("assistesaude.com.br", "/flutter/terapias_buscar.php"),
      body: {
        'idprof': loginController.idprof.value,
      },
    );
  }
}
