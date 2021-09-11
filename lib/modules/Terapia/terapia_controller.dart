import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TerapiaController extends GetxController {
  var terapias = [].obs;
  var isLoading = false.obs;

  var searchResult = [].obs;
  var search = TextEditingController().obs;

  onSearchTextChanged(String text) {
    searchResult.clear();
    if (text.isEmpty) {
      return;
    }
    terapias.forEach((details) {
      if (details.titulo!.toLowerCase().contains(text.toLowerCase()))
        searchResult.add(details);
    });
  }
}
