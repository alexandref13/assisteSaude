// import 'package:assistsaude/modules/Login/login_controller.dart';
import 'package:assistsaude/modules/Perfil/perfil_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiPerfil {
  static Future editPerfil() async {
    // LoginController loginController = Get.find(tag: 'login');
    PerfilController perfilController = Get.put(PerfilController());

    return await http.post(
        Uri.https("www.admautopecasbelem.com.br",
            "/login/flutter/perfil_alterar.php"),
        body: {
          'idusu': '27',
          'nome': perfilController.name.value.text,
          'aniversario': perfilController.newDate.value,
          'celular': perfilController.phone.value.text,
          'genero': perfilController.itemSelecionado.value,
        });
  }
}
