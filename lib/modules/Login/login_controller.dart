import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:assistsaude/modules/Login/components/list_of_clients_model.dart';
import 'package:assistsaude/modules/Login/login_repository.dart';
import 'package:assistsaude/shared/alert_button_pressed.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

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
  var imgLogoBranca = ''.obs;
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
  var emailprof = ''.obs;

  final formKey = GlobalKey<FormState>();

  getEmail() async {
    await GetStorage.init();
    final box = GetStorage();
    var newEmail = box.read('email');
    var newId = box.read('id');

    if (newEmail != null) {
      email.value.text = newEmail;
      idprof.value = newId;
    }
  }

  /*storageId() async {
    await GetStorage.init();
    final box = GetStorage();
    box.write('email', email);
    box.write('idCliente', idCliente);
  }*/

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

    isLoading(false);

    if (dadosUsuario['valida'] == 1) {
      var sendTags = {
        'idusu': dadosUsuario['idprof'],
        'nome': dadosUsuario['nome'],
        'sobrenome': dadosUsuario['sobrenome'],
        'tipousu': dadosUsuario['tipousu'],
        'idcliente': dadosUsuario['idcliente'],
      };

      OneSignal.shared.sendTags(sendTags).then((response) {
        print("Successfully sent tags with response: $response");
      }).catchError((error) {
        print("Encountered an error sending tags: $error");
      });

      hasMoreEmail(email.value.text).then(
        (value) async {
          await GetStorage.init();
          final box = GetStorage();
          box.write('id', dadosUsuario['idprof']);
          box.write('idCliente', dadosUsuario['idcliente']);

          idprof.value = dadosUsuario['idprof'];
          nome.value = dadosUsuario['nome'];
          sobrenome.value = dadosUsuario['sobrenome'];
          especialidade.value = dadosUsuario['tipousu'];
          imgperfil.value = dadosUsuario['imgperfil'];
          especialidade.value = dadosUsuario['especialidade'];
          idCliente.value = dadosUsuario['idcliente'];
          nomeCliente.value = dadosUsuario['nomecliente'];
          imgLogo.value = dadosUsuario['imglogo'];
          imgLogoBranca.value = dadosUsuario['imglogobranca'];
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
          emailprof.value = dadosUsuario['email'];

          if (value.length > 1) {
            Get.toNamed('listOfClients');
            isMoreThanOneEmail(true);
          } else {
            /*if (value.length > 1) {
              isMoreThanOneEmail(true);
            } else {
              isMoreThanOneEmail(false);
            }*/
            isMoreThanOneEmail(false);
            Get.offNamed('/home');
          }
          //Get.offNamed('/home');
          //storageId();
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
    } else if (dadosUsuario['valida'] == 0) {
      onAlertButtonPressed(
        context,
        'Login ou Senha Inválidos',
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

  storageId() async {
    await GetStorage.init();
    final box = GetStorage();
    box.write('id', idprof.value);
    box.write('idCliente', idCliente.value);
  }

  newLogin() async {
    await GetStorage.init();
    final box = GetStorage();
    var id = box.read('id');

    isLoading(true);

    final response = await LoginRepository.Newlogin(id);

    var dados = json.decode(response.body);

    var sendTags = {
      'idusu': dados['idprof'],
      'nome': dados['nome'],
      'sobrenome': dados['sobrenome'],
      'tipousu': dados['tipousu'],
      'idcliente': dados['idcliente'],
    };

    OneSignal.shared.sendTags(sendTags).then((response) {
      print("Successfully sent tags with response: $response");
    }).catchError((error) {
      print("Encountered an error sending tags: $error");
    });

    isLoading(false);

    email(dados['email']);
    idprof(dados['idprof']);
    nome(dados['nome']);
    sobrenome(dados['sobrenome']);
    tipousu(dados['tipousu']);
    imgperfil(dados['imgperfil']);
    especialidade(dados['especialidade']);
    idCliente(dados['idcliente']);
    nomeCliente(dados['nomecliente']);
    imgLogo(dados['imglogo']);
    imgLogoBranca(dados['imglogobranca']);
    slogan(dados['slogan']);
    endereco(dados['endereco']);
    complemento(dados['complemento']);
    cidade(dados['cidade']);
    bairro(dados['bairro']);
    cep(dados['cep']);
    uf(dados['uf']);
    cel(dados['cel']);
    genero(dados['genero']);
    datanas(dados['datanas']);
    idCliente(dados['idcliente']);

    storageId();

    Get.offNamed('/home');

    isLoading(false);
  }

  @override
  void onInit() async {
    deviceId = await getId();
    getEmail();
    super.onInit();
  }
}
