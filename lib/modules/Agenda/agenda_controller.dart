import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:assistsaude/modules/Agenda/api_agenda.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AgendaController extends GetxController {
  var isLoading = true.obs;
  var onSelected = false.obs;
  var periodo = TextEditingController().obs;
  var diasArray = [].obs;
  var checkeddom = false.obs;
  var checkedseg = false.obs;
  var checkedter = false.obs;
  var checkedqua = false.obs;
  var checkedqui = false.obs;
  var checkedsex = false.obs;
  var checkedsab = false.obs;
  var idcliente = ''.obs;
  var firstId = '0'.obs;
  var itemSelecionado = 'Selecione Qtd de'.obs;

  List<String> tipos = [
    'Selecione Qtd de',
    '1',
    '2',
    '4',
    '12',
  ];

  List<String> itens = [
    'Domingo',
    'Segunda',
    'Terça',
    'Quarta',
    'Quinta',
    'Sexta',
    'Sábado',
  ];

  getAgendarVisitas() async {
    diasArray = [].obs;
    if (checkeddom.value == true) {
      diasArray = diasArray + [0];
    }
    if (checkedseg.value == true) {
      diasArray = diasArray + [1];
    }
    if (checkedter.value == true) {
      diasArray = diasArray + [2];
    }
    if (checkedqua.value == true) {
      diasArray = diasArray + [3];
    }
    if (checkedqui.value == true) {
      diasArray = diasArray + [4];
    }
    if (checkedsex.value == true) {
      diasArray = diasArray + [5];
    }
    if (checkedsab.value == true) {
      diasArray = diasArray + [6];
    }

    print("dias: ${diasArray.length}");

    if (itemSelecionado.value == 'Selecione Qtd de') {
      return 'qtdvazio';
    } else if (diasArray.length == 0) {
      return 'diasvazio';
    } else {
      isLoading(true);
      var response = await ApiAgendar.agendarVisitas();
      var dados = json.decode(response.body);

      isLoading(false);
      return dados;
    }
  }

  @override
  void onInit() {
    super.onInit();
    isLoading(false);
  }
}
