import 'package:assistsaude/modules/Login/login_controller.dart';
import 'package:assistsaude/shared/circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class ListOfClients extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.find(tag: 'login');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Escolha a Empresa',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Theme.of(context).textSelectionTheme.selectionColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () {
          return loginController.isLoading.value
              ? CircularProgressIndicatorWidget()
              : Container(
                  child: ListView.builder(
                    itemCount: loginController.listOfClients.length,
                    itemBuilder: (_, i) {
                      var clients = loginController.listOfClients[i];

                      return GestureDetector(
                        onTap: () async {
                          loginController.nomeCliente.value =
                              clients.nomecliente!;
                          loginController.imgLogo.value = clients.imglogo!;
                          loginController.imgLogoBranca.value =
                              clients.imglogobranca!;
                          loginController.slogan.value = clients.slogan!;
                          loginController.idCliente.value = clients.idcliente!;
                          loginController.idprof.value = clients.idprof!;
                          loginController.nome.value = clients.nomeprof!;
                          loginController.emailprof.value = clients.emailprof!;
                          loginController.especialidade.value =
                              clients.especialidade!;
                          loginController.imgperfil.value = clients.imgperfil!;
                          await GetStorage.init();
                          final box = GetStorage();
                          box.write('id', loginController.idprof.value);

                          loginController.newLogin();

                          //Get.offAllNamed('/home');
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Colors.white,
                          child: ListTile(
                            leading: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    'https://assistesaude.com.br/downloads/fotoslogomarca/${clients.imglogo}',
                                  ),
                                ),
                              ),
                            ),
                            title: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                clients.nomecliente!,
                                style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_right,
                              color: Theme.of(context).primaryColor,
                              size: 30,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
