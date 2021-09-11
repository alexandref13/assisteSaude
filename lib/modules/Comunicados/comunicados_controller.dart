import 'dart:convert';
import 'package:assistsaude/modules/Comunicados/comunicados_model.dart';
import 'package:assistsaude/modules/Comunicados/comunicados_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComunicadosController extends GetxController {
  var comunicados = <ComunicadosModel>[].obs;
  var title = ''.obs;
  var description = ''.obs;
  var isLoading = false.obs;
  var searchResult = [].obs;
  var search = TextEditingController().obs;

  onSearchTextChanged(String text) {
    searchResult.clear();
    if (text.isEmpty) {
      return;
    }
    comunicados.forEach((details) {
      if (details.titulo!.toLowerCase().contains(text.toLowerCase()))
        searchResult.add(details);
    });
  }

  getComunicados() async {
    isLoading(true);

    final response = await ComunicadosRepository.getComunicados();

    Iterable lista = json.decode(response.body);

    comunicados.assignAll(
        lista.map((model) => ComunicadosModel.fromJson(model)).toList());

    print(json.decode(response.body));

    isLoading(false);
  }

  @override
  void onInit() {
    getComunicados();
    super.onInit();
  }
}
