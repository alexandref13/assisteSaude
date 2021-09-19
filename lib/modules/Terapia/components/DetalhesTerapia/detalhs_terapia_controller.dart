import 'dart:convert';
import 'package:assistsaude/modules/Login/login_controller.dart';
import 'package:assistsaude/modules/MapaAgenda/mapa_agenda_controller.dart';
import 'package:assistsaude/modules/Terapia/components/DetalhesTerapia/detalhes_terapia_model.dart';
import 'package:assistsaude/modules/Terapia/components/DetalhesTerapia/detalhes_terapia_repository.dart';
import 'package:assistsaude/shared/alert_button_pressed.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../terapia_controller.dart';

class DetalhesTerapiaController extends GetxController {
  TerapiaController terapiaController = Get.put(TerapiaController());
  LoginController loginController = Get.find(tag: 'login');
  MapaAgendaController mapaAgendaController = Get.put(MapaAgendaController());

  var details = <DetalhesTerapiaModel>[].obs;
  var idpftr = ''.obs;
  var ctl = ''.obs;
  var isLoading = false.obs;

  getDetails() async {
    Get.toNamed('/detalhesTerapia');

    isLoading(true);

    final response = await DetalhesTerapiaRepository.getDetails();

    print(json.decode(response.body));

    Iterable dados = json.decode(response.body);

    details.assignAll(
      dados.map((model) => DetalhesTerapiaModel.fromJson(model)).toList(),
    );

    isLoading(false);
  }

  Future<void> makePhoneCall(String cel, context) async {
    var celular = cel
        .replaceAll("(", "")
        .replaceAll(")", "")
        .replaceAll("-", "")
        .replaceAll(" ", "");

    var celFinal = "tel:$celular";

    if (await canLaunch(celFinal)) {
      await launch(celFinal);
    } else {
      onAlertButtonPressed(
          context, 'Erro! Não foi possível ligar para este celular.', () {
        Get.back();
      });
    }
  }

  abrirWhatsApp(String cel, context) async {
    var celular = cel
        .replaceAll("(", "")
        .replaceAll(")", "")
        .replaceAll("-", "")
        .replaceAll(" ", "");

    var whatsappUrl = "whatsapp://send?phone=+55$celular";

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      onAlertButtonPressed(
          context, 'Erro! Não foi possível ir para o whatsapp.', () {
        Get.back();
      });
    }
  }

  goToMap(String latLng) async {
    var newLatLng = latLng.split(',');

    mapaAgendaController.lat.value = double.parse(newLatLng[0]);
    mapaAgendaController.lng.value = double.parse(newLatLng[1]);

    await mapaAgendaController.getClientes();

    Get.toNamed('/mapaAgenda');
  }

  aceitarRecusar() async {
    isLoading(true);

    Get.back();

    final response = await DetalhesTerapiaRepository.aceitarRecusar();

    var dados = json.decode(response.body);

    print(dados);

    terapiaController.getTerapias();

    loginController.selectedIndex.value = 2;

    Get.offAllNamed('/home');

    isLoading(false);
  }
}
