// import 'package:assistsaude/modules/Login/login_controller.dart';
import 'package:assistsaude/modules/MapaAgenda/mapa_agenda_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MapaAgendaRepository {
  static Future doCheckin() async {
    MapaAgendaController mapaAgendaController = Get.put(MapaAgendaController());

    print('Lat:${mapaAgendaController.ourLat.value.toString()}');
    return await http.post(
      Uri.https("assistesaude.com.br", "/flutter/check.php"),
      body: {
        'idsessao': mapaAgendaController.idSessao.value,
        'lat': mapaAgendaController.ourLat.value.toString(),
        'lng': mapaAgendaController.ourLng.value.toString(),
        'latpac': mapaAgendaController.lat.value.toString(),
        'lngpac': mapaAgendaController.lng.value.toString(),
        'ctlcheckin': mapaAgendaController.ctlcheckin.value,
      },
    );
  }

  static Future doReset() async {
    MapaAgendaController mapaAgendaController = Get.put(MapaAgendaController());

    return await http.post(
      Uri.https("assistesaude.com.br", "/flutter/resetsessao.php"),
      body: {
        'idsessao': mapaAgendaController.idSessao.value,
      },
    );
  }

  static Future doObs() async {
    MapaAgendaController mapaAgendaController = Get.put(MapaAgendaController());

    return await http.post(
      Uri.https("assistesaude.com.br", "/flutter/sessao_obs_incluir.php"),
      body: {
        'idsessao': mapaAgendaController.idSessao.value,
        'obs': mapaAgendaController.observacao.value.text,
      },
    );
  }

  static Future doEvolucao() async {
    MapaAgendaController mapaAgendaController = Get.put(MapaAgendaController());

    return await http.post(
      Uri.https("assistesaude.com.br", "/flutter/sessao_evolucao_incluir.php"),
      body: {
        'idsessao': mapaAgendaController.idSessao.value,
        'evolcao': mapaAgendaController.evolucao.value.text,
      },
    );
  }

  static Future verGps() async {
    MapaAgendaController mapaAgendaController = Get.put(MapaAgendaController());
    print('VER SESSÃO: ${mapaAgendaController.idSessao.value}');
    return await http.post(
      Uri.https("assistesaude.com.br", "/flutter/verGPS.php"),
      body: {'idsessao': mapaAgendaController.idSessao.value},
    );
  }

  static Future doChangeGps() async {
    MapaAgendaController mapaAgendaController = Get.put(MapaAgendaController());

    print(
        "idsessao: ${mapaAgendaController.idSessao.value} idpac: ${mapaAgendaController.idPaciente.value} lat: ${mapaAgendaController.ourLat.value.toString()}  lng: ${mapaAgendaController.ourLng.value.toString()} ");

    return await http.post(
      Uri.https("assistesaude.com.br", "/flutter/alterargpsNovo.php"),
      body: {
        'idpac': mapaAgendaController.idPaciente.value,
        'idsessao': mapaAgendaController.idSessao.value,
        'lat': mapaAgendaController.ourLat.value.toString(),
        'lng': mapaAgendaController.ourLng.value.toString(),
      },
    );
  }

  static Future deleteClient() async {
    MapaAgendaController mapaAgendaController = Get.put(MapaAgendaController());

    return await http.post(
      Uri.https("assistesaude.com.br", "/flutter/sessoes_excluir.php"),
      body: {
        'idsessao': mapaAgendaController.idSessao.value,
      },
    );
  }
}
