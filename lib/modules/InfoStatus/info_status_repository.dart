import 'package:assistsaude/modules/InfoStatus/info_status_controller.dart';
import 'package:assistsaude/modules/Terapia/components/DetalhesTerapia/detalhs_terapia_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class InfoStatusRepository {
  static Future getStatus() async {
    return await http.post(
      Uri.https("assistesaude.com.br", "/flutter/status_pesquisa.php"),
    );
  }

  static Future doInfoStatus() async {
    DetalhesTerapiaController detalhesTerapiaController =
        Get.put(DetalhesTerapiaController());
    InfoStatusController infoStatusController = Get.put(InfoStatusController());

    print({
      infoStatusController.firstId.value,
      detalhesTerapiaController.idpftr.value,
      infoStatusController.observation.value.text,
    });

    return await http.post(
      Uri.https(
        "assistesaude.com.br",
        "/flutter/status_alterar.php",
      ),
      body: {
        'idstatus': infoStatusController.firstId.value,
        'idpftr': detalhesTerapiaController.idpftr.value,
        'obs_status': infoStatusController.observation.value.text,
      },
    );
  }
}
