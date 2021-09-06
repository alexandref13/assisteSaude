import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LoginController extends GetxController {
  var email = TextEditingController().obs;
  var password = TextEditingController().obs;
  var isLoading = false.obs;
  var idprof = ''.obs;
  var nome = ''.obs;
  var sobrenome = ''.obs;
  var tipousu = ''.obs;
  var imgperfil = ''.obs;
  var especialidade = ''.obs;

  final formKey = GlobalKey<FormState>();

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onLoading() async {
    refreshController.loadComplete();
  }

  login() async {
    isLoading(true);

    final response = await http
        .post(Uri.https("assistesaude.com.br", '/flutter/login.php'), body: {
      "emal": email.value.text,
      "senha": password.value.text,
    });
    isLoading(false);

    var dadosUsuario = json.decode(response.body);

    print(dadosUsuario);

    if (dadosUsuario['valida'] == 1) {
      return dadosUsuario;
    } else {
      return null;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}
