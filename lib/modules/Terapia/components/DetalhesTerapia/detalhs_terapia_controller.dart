import 'dart:convert';
import 'package:assistsaude/modules/Terapia/components/DetalhesTerapia/detalhes_terapia_model.dart';
import 'package:assistsaude/modules/Terapia/components/DetalhesTerapia/detalhes_terapia_repository.dart';
import 'package:get/get.dart';

class DetalhesTerapiaController extends GetxController {
  var details = <DetalhesTerapiaModel>[].obs;
  var idpftr = ''.obs;
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
}
