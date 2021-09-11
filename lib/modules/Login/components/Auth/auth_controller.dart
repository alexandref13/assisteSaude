import 'package:assistsaude/modules/Login/components/Auth/auth_repository.dart';
import 'package:assistsaude/modules/Login/login_controller.dart';
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

  authenticate() async {
    if (await _isBiometricAvailable()) {
      await autoLogIn();
    }
  }

  Future<bool> _isBiometricAvailable() async {
    bool isAvailable = await localAuthentication.canCheckBiometrics;
    return isAvailable;
  }

  Future<void> autoLogIn() async {
    await GetStorage.init();
    final box = GetStorage();
    var id = box.read('id');
    var email = box.read('emailS');
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

        var dados = json.decode(response.body);

        print(dados);
      } else {
        loginController.isLoading.value = false;
        return;
      }
    }
  }

  @override
  void onInit() {
    localAuthentication.isDeviceSupported().then((isSupported) {
      if (isSupported) {
        authenticate();
      }
    });
    super.onInit();
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