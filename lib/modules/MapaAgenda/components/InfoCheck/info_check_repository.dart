import 'package:assistsaude/modules/MapaAgenda/mapa_agenda_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'info_check_controller.dart';

class InfoCheckRepository {
  static Future changeHours() async {
    MapaAgendaController mapaAgendaController = Get.put(MapaAgendaController());
    InfoCheckController infoCheckController = Get.put(InfoCheckController());

    print(infoCheckController.hour.value.text);
    return await http.post(
      Uri.https("assistesaude.com.br", "/flutter/info_check.php"),
      body: {
        'idsessao': mapaAgendaController.idSessao.value,
        'ctlcheck': mapaAgendaController.ctlcheckin.value,
        'time': infoCheckController.hour.value.text,
        'dataformat': mapaAgendaController.dtagenda.value,
      },
    );
  }
}
