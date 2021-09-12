import 'dart:convert';
import 'package:assistsaude/modules/Agenda/calendario_controller.dart';
import 'package:assistsaude/modules/Login/login_controller.dart';
import 'package:assistsaude/modules/Terapia/components/DetalhesTerapia/detalhes_terapia_model.dart';
import 'package:assistsaude/modules/Terapia/components/DetalhesTerapia/detalhes_terapia_repository.dart';
import 'package:get/get.dart';

import '../../terapia_controller.dart';

class DetalhesTerapiaController extends GetxController {
  TerapiaController terapiaController = Get.put(TerapiaController());
  LoginController loginController = Get.find(tag: 'login');

  var details = <DetalhesTerapiaModel>[].obs;
  var idpftr = ''.obs;
  var ctl = ''.obs;
  var isLoading = false.obs;

  getDetails() async {
    Get.toNamed('/detalhesTerapia');

    isLoading(true);

    final response = await DetalhesTerapiaRepository.getDetails();

    Iterable dados = json.decode(response.body);

    details.assignAll(
      dados.map((model) => DetalhesTerapiaModel.fromJson(model)).toList(),
    );

    isLoading(false);
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
