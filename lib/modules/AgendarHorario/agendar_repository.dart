import 'package:assistsaude/modules/AgendarHorario/agendarhorario.controller.dart';
import 'package:assistsaude/modules/MapaAgenda/mapa_agenda_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AgendarRepository {
  static Future changeHours() async {
    MapaAgendaController mapaAgendaController = Get.put(MapaAgendaController());
    AgendaHorarioController agendaHorarioController =
        Get.put(AgendaHorarioController());

    print({
      mapaAgendaController.idSessao.value,
      agendaHorarioController.hour.value.text,
      mapaAgendaController.dtagenda.value,
    });

    return await http.post(
      Uri.https("assistesaude.com.br", "flutter/agendar_horario.php"),
      body: {
        'idsessao': mapaAgendaController.idSessao.value,
        'time': agendaHorarioController.hour.value.text,
        'dataformat': mapaAgendaController.dtagenda.value,
      },
    );
  }
}
