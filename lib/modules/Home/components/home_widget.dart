import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../home_controller.dart';

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());

    return SafeArea(
      child: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     fit: BoxFit.fill,
        //     image: AssetImage(
        //       "images/unnamed.jpg",
        //     ),
        //   ),
        // ),
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
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 24),
              child: Image.asset(
                "images/logo.png",
                fit: BoxFit.fill,
                width: 150,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 16),
              child: Text(
                'Saúde, Humanização e Tecnologia',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
