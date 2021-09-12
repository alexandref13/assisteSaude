import 'dart:convert';

import 'package:assistsaude/modules/Terapia/terapia_model.dart';
import 'package:assistsaude/modules/Terapia/terapia_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TerapiaController extends GetxController {
  var terapias = <TerapiaModel>[].obs;
  var isLoading = false.obs;
  var searchResult = [].obs;
  var search = TextEditingController().obs;

  onSearchTextChanged(String text) {
    searchResult.clear();
    if (text.isEmpty) {
      return;
    }
    terapias.forEach((details) {
      if (details.nomepac!.toLowerCase().contains(text.toLowerCase()))
        searchResult.add(details);
    });
  }

  Future<void> onRefresh() async {
    await getTerapias();
  }

  getTerapias() async {
    isLoading(true);

    final response = await TerapiaRepository.getTerapias();

    print(json.decode(response.body));

    Iterable dados = json.decode(response.body);

    terapias.assignAll(
      dados.map((model) => TerapiaModel.fromJson(model)).toList(),
    );

    isLoading(false);
  }

  @override
  void onInit() {
    getTerapias();
    super.onInit();
  }
}
