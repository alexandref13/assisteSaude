// import 'package:assistsaude/modules/Login/login_controller.dart';
import 'package:assistsaude/modules/Login/login_controller.dart';
import 'package:assistsaude/modules/Perfil/perfil_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiPerfil {
  static Future editPerfil() async {
    LoginController loginController = Get.find(tag: 'login');
    PerfilController perfilController = Get.put(PerfilController());

    print("Datanas: ${perfilController.newDate.value}");
    return await http.post(
      Uri.https("assistesaude.com.br", "flutter/editar_perfil.php"),
      body: {
        'idprof': loginController.idprof.value,
        'nome': perfilController.name.value.text,
        'sobrenome': perfilController.secondName.value.text,
        'dtnasc': perfilController.newDate.value,
        'end': perfilController.endereco.value.text,
        'comp': perfilController.complemento.value.text,
        'bairro': perfilController.bairro.value.text,
        'cidade': perfilController.cidade.value.text,
        'cel': perfilController.phone.value.text,
        'cep': perfilController.cep.value.text,
        'uf': perfilController.uf.value.text,
        'tel': perfilController.phone.value.text,
        'genero': perfilController.itemSelecionado.value,
      },
    );
  }
}
