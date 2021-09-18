import 'dart:convert';
import 'dart:io';
import 'package:assistsaude/modules/Login/components/list_of_clients_model.dart';
import 'package:assistsaude/modules/Login/login_repository.dart';
import 'package:assistsaude/shared/alert_button_pressed.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  var listOfClients = <ListOfClientsModel>[].obs;
  var email = TextEditingController().obs;
  var password = TextEditingController().obs;
  var isLoading = false.obs;
  var isMoreThanOneEmail = false.obs;
  var idprof = ''.obs;
  var idCliente = ''.obs;
  var idSessao = ''.obs;
  var nome = ''.obs;
  var sobrenome = ''.obs;
  var tipousu = ''.obs;
  var imgperfil = ''.obs;
  var especialidade = ''.obs;
  var nomeCliente = ''.obs;
  var imgLogo = ''.obs;
  var slogan = ''.obs;
  var deviceId = '';
  var endereco = ''.obs;
  var complemento = ''.obs;
  var cidade = ''.obs;
  var bairro = ''.obs;
  var cep = ''.obs;
  var uf = ''.obs;
  var cel = ''.obs;
  var genero = ''.obs;
  var datanas = ''.obs;
  var selectedIndex = 0.obs;

  final formKey = GlobalKey<FormState>();

  hasMoreEmail(String? emailS) async {
    isLoading(true);

    await GetStorage.init();
    final box = GetStorage();
    box.write('email', emailS);

    final response = await LoginRepository.hasMoreEmail(emailS);

    Iterable dados = json.decode(response.body);

    listOfClients.assignAll(
      dados.map((model) => ListOfClientsModel.fromJson(model)).toList(),
    );

    isLoading(false);

    return listOfClients;
  }

  login(context) async {
    isLoading(true);

    final response = await LoginRepository.login();

    var dadosUsuario = json.decode(response.body);

    print(dadosUsuario);

    isLoading(false);

    if (dadosUsuario['valida'] == 1) {
      hasMoreEmail(email.value.text).then(
        (value) async {
          await GetStorage.init();
          final box = GetStorage();
          box.write('id', dadosUsuario['idprof']);

          idprof.value = dadosUsuario['idprof'];
          nome.value = dadosUsuario['nome'];
          sobrenome.value = dadosUsuario['sobrenome'];
          tipousu.value = dadosUsuario['tipousu'];
          imgperfil.value = dadosUsuario['imgperfil'];
          especialidade.value = dadosUsuario['especialidade'];
          idCliente.value = dadosUsuario['idcliente'];
          nomeCliente.value = dadosUsuario['nomecliente'];
          imgLogo.value = dadosUsuario['imglogo'];
          slogan.value = dadosUsuario['slogan'];
          endereco.value = dadosUsuario['endereco'];
          complemento.value = dadosUsuario['complemento'];
          cidade.value = dadosUsuario['cidade'];
          bairro.value = dadosUsuario['bairro'];
          cep.value = dadosUsuario['cep'];
          uf.value = dadosUsuario['uf'];
          cel.value = dadosUsuario['cel'];
          genero.value = dadosUsuario['genero'];
          datanas.value = dadosUsuario['datanas'];

          if (value.length > 1) {
            Get.toNamed('listOfClients');
            isMoreThanOneEmail(true);
          } else {
            Get.offNamed('/home');
            isMoreThanOneEmail(false);
          }
        },
      );
    } else if (dadosUsuario['valida'] == 2) {
      onAlertButtonPressed(
        context,
        'Identificamos que outro dispositivo está fazendo uso do app. Fale com a administração para realizar a liberação',
        () {
          password.value.text = '';
          Get.back();
        },
      );
    } else {
      onAlertButtonPressed(
        context,
        'Algo deu errado',
        () {
          password.value.text = '';
          Get.back();
        },
      );
    }

    // if (dadosUsuario['valida'] == 1) {
  }

  Future<String> getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor;
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId;
    }
  }

  @override
  void onInit() async {
    deviceId = await getId();
    super.onInit();
  }
}
