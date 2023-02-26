import 'package:assistsaude/modules/Login/login_controller.dart';
import 'package:assistsaude/shared/delete_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../home_controller.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    LoginController loginController = Get.find(tag: 'login');

    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: IconButton(
                      onPressed: () {
                        homeController.key.currentState!.openDrawer();
                      },
                      icon: Icon(
                        Icons.menu,
                        size: 30,
                        color:
                            Theme.of(context).textSelectionTheme.selectionColor,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                padding: EdgeInsets.fromLTRB(5, 150, 5, 0),
                width: 200,
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image:
                      'https://assistesaude.com.br/downloads/fotoslogomarca/${loginController.imgLogoBranca}',
                ),
              ),
              Container(
                child: Text(
                  loginController.slogan.value,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                    fontSize: 12,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
