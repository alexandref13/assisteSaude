import 'package:assistsaude/modules/Login/login_controller.dart';
import 'package:assistsaude/modules/Session/session_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class VisitasRepository {
  static Future getSessions() async {
    LoginController loginController = Get.find(tag: 'login');

    return await http.post(
      Uri.https("assistesaude.com.br", "flutter/pacientes_lista.php"),
      body: {
        'idprof': loginController.idprof.value,
      },
    );
  }

  static Future doRelatorios() async {
    LoginController loginController = Get.find(tag: 'login');
    SessionController sessionController = Get.put(SessionController());

    print({
      loginController.idprof.value,
      sessionController.firstId.value,
      sessionController.initialDate.value,
      sessionController.finalDate.value,
    });

    return await http.post(
      Uri.https("assistesaude.com.br", "flutter/sessoes_relatorio.php"),
      body: {
        'idprof': loginController.idprof.value,
        'idpaciente': sessionController.firstId.value,
        'datainicial': sessionController.initialDate.value,
        'datafinal': sessionController.finalDate.value,
      },
    );
  }
}
