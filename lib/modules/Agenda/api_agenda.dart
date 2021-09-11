import 'package:assistsaude/modules/Agenda/agenda_controller.dart';
import 'package:assistsaude/modules/Login/login_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiAgendar {
  static Future agendarVisitas() async {
    LoginController loginController = Get.find(tag: 'login');
    AgendaController agendaController = Get.put(AgendaController());

    print("perido: ${agendaController.diasArray.toString()} ");

    return await http.post(
      Uri.https(
          "www.admautopecasbelem.com.br", "login/flutter/agendar_visitas.php"),
      body: {
        'idusu': '27',
        'idcliente': agendaController.idcliente.value,
        'periodo': agendaController.itemSelecionado.value,
        'dias': agendaController.diasArray.toString(),
      },
    );
  }
}
/*
  static Future getReservas() async {
    LoginController loginController = Get.put(LoginController());

    return await http.post(
      Uri.https("www.condosocio.com.br", "/flutter/reservas_morador.php"),
      body: {
        'idusu': loginController.id.value,
      },
    );
  }

  static Future agendaReservas() async {
    LoginController loginController = Get.put(LoginController());
    ReservasController reservasController = Get.put(ReservasController());

    return await http.post(
      Uri.https("www.condosocio.com.br", "/flutter/reservas_agenda.php"),
      body: {
        'idcond': loginController.idcond.value,
        'idusu': loginController.id.value,
        'nome_area': reservasController.nome.value,
        'idarea': reservasController.idarea.value,
      },
    );
  }

  static Future incluirReserva() async {
    LoginController loginController = Get.put(LoginController());
    ReservasController reservasController = Get.put(ReservasController());
    AddReservasController addReservasController =
        Get.put(AddReservasController());

    return await http.post(
      Uri.https("www.condosocio.com.br", "/flutter/reservas_inc.php"),
      body: {
        'idcond': loginController.idcond.value,
        'idusu': loginController.id.value,
        'idarea': reservasController.idarea.value,
        'titulo': addReservasController.titulo.value.text,
        'data_evento': addReservasController.date.value,
        'hora_evento': addReservasController.hora.value,
        'aprova': reservasController.aprova.value,
      },
    );
  }

  static Future deleteReserva() async {
    DetalhesReservasController detalhesReservasController =
        Get.put(DetalhesReservasController());
    LoginController loginController = Get.put(LoginController());

    return await http.post(
      Uri.https("www.condosocio.com.br", "/flutter/reserva_excluir.php"),
      body: {
        'ideve': detalhesReservasController.idEve.value,
        'idusu': loginController.id.value,
      },
    );
  }
}*/