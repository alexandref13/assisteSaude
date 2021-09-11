import 'package:assistsaude/modules/Login/login_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  static Future authenticate(String? idProf) async {
    LoginController loginController = Get.find(tag: 'login');

    return await http.post(
      Uri.https("assistesaude.com.br", "/flutter/dados_prof.php"),
      body: {
        'idprof': idProf,
        'iddevice': loginController.deviceId,
      },
    );
  }
}
