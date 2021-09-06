import 'package:assistsaude/modules/Login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.find(tag: 'login');

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Center(
          child: Text('${loginController.email.value.text}'),
        ),
      ),
    );
  }
}
