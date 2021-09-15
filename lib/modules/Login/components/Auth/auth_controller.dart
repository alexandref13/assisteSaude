import 'package:assistsaude/modules/Login/components/Auth/auth_repository.dart';
import 'package:assistsaude/modules/Login/login_controller.dart';
import 'package:assistsaude/shared/alert_button_pressed.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthController extends GetxController {
  LocalAuthentication localAuthentication = LocalAuthentication();
  LoginController loginController = Get.find(tag: 'login');

  bool? canCheckBiometrics;
  List<BiometricType>? availableBiometrics;
  bool isAuthenticating = false;

  authenticate(context) async {
    if (await _isBiometricAvailable()) {
      await autoLogIn(context);
    }
  }

  Future<bool> _isBiometricAvailable() async {
    bool isAvailable = await localAuthentication.canCheckBiometrics;
    return isAvailable;
  }

  Future<void> autoLogIn(context) async {
    await GetStorage.init();
    final box = GetStorage();
    var id = box.read('id');
    var email = box.read('email');
    if (id != null) {
      bool isAuthenticated = await localAuthentication.authenticate(
        localizedReason: "Autenticar para realizar Login na plataforma",
        biometricOnly: true,
        stickyAuth: true,
        useErrorDialogs: true,
        iOSAuthStrings: IOSAuthMessages(
          cancelButton: "Cancelar",
        ),
        androidAuthStrings: AndroidAuthMessages(
          biometricHint: "Para acesso rapido entre com sua biometria",
          signInTitle: "Entre com a biometria",
          cancelButton: "Cancelar",
        ),
      );
      if (isAuthenticated) {
        loginController.isLoading.value = true;

        final response = await AuthRepository.authenticate(id);

        var dadosUsuario = json.decode(response.body);

        print(dadosUsuario);

        if (dadosUsuario['valida'] == 1) {
          loginController.hasMoreEmail(email).then(
            (value) async {
              await GetStorage.init();
              final box = GetStorage();
              box.write('id', dadosUsuario['idprof']);

              loginController.email.value.text = email;
              loginController.idprof.value = dadosUsuario['idprof'];
              loginController.nome.value = dadosUsuario['nome'];
              loginController.sobrenome.value = dadosUsuario['sobrenome'];
              loginController.tipousu.value = dadosUsuario['tipousu'];
              loginController.imgperfil.value = dadosUsuario['imgperfil'];
              loginController.especialidade.value =
                  dadosUsuario['especialidade'];
              loginController.idCliente.value = dadosUsuario['idcliente'];
              loginController.nomeCliente.value = dadosUsuario['nomecliente'];
              loginController.imgLogo.value = dadosUsuario['imglogo'];
              loginController.slogan.value = dadosUsuario['slogan'];
              loginController.idSessao.value = dadosUsuario['idsessao'];

              if (value.length > 1) {
                Get.toNamed('listOfClients');
                loginController.isMoreThanOneEmail(true);
              } else {
                Get.offNamed('/home');
                loginController.isMoreThanOneEmail(false);
              }
            },
          );
        } else if (dadosUsuario['valida'] == 2) {
          onAlertButtonPressed(
            context,
            'Identificamos que outro dispositivo está fazendo uso do app. Fale com a administração para realizar a liberação',
            () {
              loginController.password.value.text = '';
              Get.back();
            },
          );
        } else {
          onAlertButtonPressed(
            context,
            'Algo deu errado',
            () {
              loginController.password.value.text = '';
              Get.back();
            },
          );
        }

        loginController.isLoading.value = false;
      } else {
        loginController.isLoading.value = false;
        return;
      }
    }
  }
}

//  http.post(Uri.https('www.condosocio.com.br', '/flutter/dados_usu.php'),
//             body: {"id": id}).then((response) {
//           loginController.hasMoreEmail(email).then((value) {
//             if (value.length > 1) {
//               Get.toNamed('/listOfCondo');
//             } else {
//               Get.toNamed('/home');
//               loginController.isLoading.value = false;
//             }
//           });
//         });