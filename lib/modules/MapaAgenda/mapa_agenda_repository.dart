import 'package:assistsaude/modules/MapaAgenda/mapa_agenda_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MapaAgendaRepository {
  static Future doCheckin() async {
    MapaAgendaController mapaAgendaController = Get.put(MapaAgendaController());

    return await http.post(
      Uri.https("www.admautopecasbelem.com.br", "/login/flutter/check.php"),
      body: {
        'idvisita': mapaAgendaController.idVisita.value,
        'lat': mapaAgendaController.ourLat.value.toString(),
        'lng': mapaAgendaController.ourLng.value.toString(),
        'latcliente': mapaAgendaController.lat.value.toString(),
        'lngcliente': mapaAgendaController.lng.value.toString(),
        'ctlcheckin': mapaAgendaController.ctlcheckin.value,
      },
    );
  }

  static Future doObs() async {
    MapaAgendaController mapaAgendaController = Get.put(MapaAgendaController());

    return await http.post(
      Uri.https("www.admautopecasbelem.com.br",
          "/login/flutter/visitas_obs_incluir.php"),
      body: {
        'idvisita': mapaAgendaController.idVisita.value,
        'obs': mapaAgendaController.observacao.value.text,
      },
    );
  }

  static Future doChangeGps() async {
    MapaAgendaController mapaAgendaController = Get.put(MapaAgendaController());

    return await http.post(
      Uri.https("www.admautopecasbelem.com.br", "login/flutter/alterargps.php"),
      body: {
        'idcliente': mapaAgendaController.idCliente.value,
        'lat': mapaAgendaController.ourLat.value.toString(),
        'lng': mapaAgendaController.ourLng.value.toString(),
      },
    );
  }

  static Future deleteClient() async {
    MapaAgendaController mapaAgendaController = Get.put(MapaAgendaController());

    return await http.post(
      Uri.https(
          "www.admautopecasbelem.com.br", "login/flutter/visitas_excluir.php"),
      body: {
        'idvisita': mapaAgendaController.idVisita.value,
      },
    );
  }
}
