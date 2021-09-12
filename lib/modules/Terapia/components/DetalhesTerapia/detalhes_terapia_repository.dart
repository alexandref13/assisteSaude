import 'package:assistsaude/modules/Terapia/components/DetalhesTerapia/detalhs_terapia_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DetalhesTerapiaRepository {
  static Future getDetails() async {
    DetalhesTerapiaController detalhesTerapiaController =
        Get.put(DetalhesTerapiaController());

    print(detalhesTerapiaController.idpftr.value);

    return await http.post(
      Uri.https("assistesaude.com.br", "flutter/pacientes_detalhes.php"),
      body: {
        'idpftr': detalhesTerapiaController.idpftr.value,
      },
    );
  }

  static Future aceitarRecusar() async {
    DetalhesTerapiaController detalhesTerapiaController =
        Get.put(DetalhesTerapiaController());

    print(detalhesTerapiaController.idpftr.value);

    return await http.post(
      Uri.https("assistesaude.com.br", "/flutter/aceitar_recusar.php"),
      body: {
        'idpftr': detalhesTerapiaController.idpftr.value,
        'ctl': detalhesTerapiaController.ctl.value,
      },
    );
  }
}
