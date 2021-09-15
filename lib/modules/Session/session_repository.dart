import 'package:assistsaude/modules/Login/login_controller.dart';
import 'package:assistsaude/modules/Session/session_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class VisitasRepository {
  static Future getSessions() async {
    LoginController loginController = Get.find(tag: 'login');

    return await http.post(
      Uri.https("assistesaude.com.br", "flutter/sessoes_agenda.php"),
      body: {
        'idprof': loginController.idprof.value,
      },
    );
  }

  // static Future doRelatorios() async {
  //   LoginController loginController = Get.put(LoginController());
  //   SessionController sessionController = Get.put(SessionController());

  //   return await http.post(
  //     Uri.https("www.admautopecasbelem.com.br",
  //         "login/flutter/visitas_relatorio.php"),
  //     body: {
  //       'idusu': '27',
  //       'idcliente': sessionController.firstId.value,
  //       'datainicial': sessionController.initialDate.value,
  //       'datafinal': sessionController.finalDate.value,
  //     },
  //   );
  // }
}
