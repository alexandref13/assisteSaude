import 'dart:convert';
import 'package:assistsaude/modules/Session/components/DataTable/data_table_visitas_controller.dart';
import 'package:assistsaude/modules/Session/session_repository.dart';
import 'package:assistsaude/shared/alert_button_pressed.dart';
import 'package:get/get.dart';

class SessionController extends GetxController {
  DataTableController dataTableController = Get.put(DataTableController());

  var clientes = [].obs;
  var initialDate = ''.obs;
  var finalDate = ''.obs;
  var firstId = '0'.obs;
  var isLoading = false.obs;

  getSessions() async {
    isLoading(true);

    final response = await VisitasRepository.getVisitantes();

    var dados = json.decode(response.body);

    clientes.assignAll(dados);

    isLoading(false);
  }

  doRelatorios(context) async {
    isLoading(true);

    final response = await VisitasRepository.doRelatorios();

    var dados = json.decode(response.body);

    if (dados == null) {
      onAlertButtonPressed(
        context,
        'Sem Registros de Sessões!',
        () {
          Get.offAllNamed('/home');
        },
      );
    }

    dataTableController.data.assignAll(dados);

    Get.toNamed('/dataTableVisitas');

    dataTableController.isLoading(false);

    isLoading(false);
  }

  @override
  void onInit() {
    getSessions();
    super.onInit();
  }
}
