import 'package:assistsaude/modules/Home/home_controller.dart';
import 'package:assistsaude/modules/Login/components/Auth/auth_controller.dart';
import 'package:assistsaude/shared/alert_button_pressed.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthController authController = Get.put(AuthController());
  HomeController homeController = Get.put(HomeController());
  LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    authController.localAuthentication.isDeviceSupported().then((isSupported) {
      if (isSupported) {
        authController.authenticate(context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.find(tag: 'login');

    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(
          () {
            return Stack(
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Column(children: <Widget>[
                      Center(
                        child: Container(
                          padding: const EdgeInsets.only(top: 80),
                          child: Image.asset(
                            "images/logobranca.png",
                            fit: BoxFit.fill,
                            width: 120,
                          ),
                        ),
                      ),
                    ])),
                Positioned(
                  top: 220,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        color:
                            Theme.of(context).textSelectionTheme.selectionColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        )),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Center(
                      child: Form(
                        autovalidateMode: AutovalidateMode.always,
                        key: loginController.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 320, 20, 20),
                              child: Container(
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  style: GoogleFonts.montserrat(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: new EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 15),
                                    focusedBorder: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    labelText: 'Entre com o e-mail',
                                    labelStyle: GoogleFonts.montserrat(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 14),
                                    errorBorder: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color:
                                                Theme.of(context).errorColor)),
                                    focusedErrorBorder: new OutlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: Colors.red)),
                                    errorStyle: GoogleFonts.montserrat(
                                        color: Theme.of(context).errorColor),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (valueEmail) {
                                    if (!EmailValidator.validate(valueEmail!)) {
                                      return 'Entre com E-mail Válido!';
                                    }
                                    return null;
                                  },
                                  controller: loginController.email.value,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 15, 20, 20),
                              child: Container(
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  obscureText: true,
                                  style: GoogleFonts.montserrat(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: new EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 15),
                                    focusedBorder: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    labelText: 'Entre com a senha',
                                    labelStyle: GoogleFonts.montserrat(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 14),
                                    errorBorder: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color:
                                                Theme.of(context).errorColor)),
                                    focusedErrorBorder: new OutlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: Colors.red)),
                                    errorStyle: GoogleFonts.montserrat(
                                        color: Theme.of(context).errorColor),
                                  ),
                                  keyboardType: TextInputType.text,
                                  validator: (valueSenha) {
                                    if (valueSenha == "") {
                                      return 'Campo Senha Vazio!';
                                    }
                                    return null;
                                  },
                                  controller: loginController.password.value,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: ButtonTheme(
                                height: 50.0,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        return Theme.of(context).primaryColor;
                                      },
                                    ),
                                    shape: MaterialStateProperty.resolveWith<
                                        OutlinedBorder>(
                                      (Set<MaterialState> states) {
                                        return RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        );
                                      },
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (loginController.email.value.text ==
                                            '' ||
                                        loginController.password.value.text ==
                                            '') {
                                      onAlertButtonPressed(
                                        context,
                                        'Campo de E-mail ou Senha Vazios',
                                        () {
                                          Get.back();
                                        },
                                      );
                                    }
                                    if (loginController.formKey.currentState!
                                        .validate()) {
                                      await loginController.login(context);
                                    }
                                  },
                                  child: loginController.isLoading.value
                                      ? SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation(
                                              Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor,
                                            ),
                                          ),
                                        )
                                      : Text(
                                          "Entrar",
                                          style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                  child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 30, 0, 20),
                                    child: GestureDetector(
                                      onTap: () {
                                        homeController.abrirWhatsApp(
                                            '5591981220670', context);
                                      },
                                      child: Text(
                                        "Fale com o Suporte",
                                        style: GoogleFonts.montserrat(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 12),
                                        textDirection: TextDirection.ltr,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.toNamed('/esqueci');
                                      },
                                      child: Text(
                                        "Esqueceu a Senha?",
                                        style: GoogleFonts.montserrat(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 12),
                                        textDirection: TextDirection.ltr,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
