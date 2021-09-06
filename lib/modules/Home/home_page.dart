import 'package:assistsaude/modules/Home/components/agenda_widget.dart';
import 'package:assistsaude/modules/Home/components/comunidados_widget.dart';
import 'package:assistsaude/modules/Home/components/home_widget.dart';
import 'package:assistsaude/modules/Home/components/terapias_widget.dart';
import 'package:assistsaude/modules/Login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    LoginController loginController = Get.find(tag: 'login');

    List<Widget> bottomNavigationList = <Widget>[
      HomeWidget(),
      ComunicadosWidget(),
      TerapiasWidget(),
      AgendaWidget()
    ];

    return Scaffold(
      key: homeController.key,
      drawer: Drawer(
        child: Container(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                  padding: EdgeInsets.all(0),
                  child: Container(
                    padding: EdgeInsets.only(top: 20),
                    color: Theme.of(context).accentColor,
                    child: Column(
                      children: <Widget>[
                        // getImageWidget(),
                        Container(
                          child: Text(
                            "${loginController.nome.value}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: GoogleFonts.montserrat(
                                color: Theme.of(context).buttonColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 2),
                          child: Text(
                            "${loginController.email.value.text}",
                            style: GoogleFonts.montserrat(
                              fontSize: 10,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 2),
                          child: Text(
                            '${loginController.tipousu.value}',
                            style: GoogleFonts.montserrat(
                              color: Theme.of(context).primaryColor,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              Column(
                children: <Widget>[
                  Container(
                    child: ListTile(
                      contentPadding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                      dense: true,
                      title: Text(
                        'Perfil',
                        style: GoogleFonts.montserrat(
                          color: Theme.of(context).primaryColor,
                          fontSize: 12,
                        ),
                      ),
                      leading: Icon(
                        Icons.person_outline,
                        color: Theme.of(context).primaryColor,
                        size: 22,
                      ),
                      onTap: () {
                        Get.toNamed('/perfil');
                      },
                    ),
                  ),
                  Divider(
                    height: 5,
                    color: Theme.of(context).primaryColor,
                  ),
                  Container(
                    child: ListTile(
                      contentPadding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                      dense: true,
                      title: Text(
                        'Senha',
                        style: GoogleFonts.montserrat(
                          color: Theme.of(context).primaryColor,
                          fontSize: 12,
                        ),
                      ),
                      leading: Icon(
                        Icons.lock_outline,
                        color: Theme.of(context).primaryColor,
                        size: 22,
                      ),
                      onTap: () {
                        Get.toNamed('/senha');
                      },
                    ),
                  ),
                  Divider(
                    height: 5,
                    color: Theme.of(context).primaryColor,
                  ),
                  Container(
                    child: ListTile(
                      contentPadding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                      dense: true,
                      title: Text(
                        'Sessões',
                        style: GoogleFonts.montserrat(
                          color: Theme.of(context).primaryColor,
                          fontSize: 12,
                        ),
                      ),
                      leading: Icon(
                        Icons.lock_outline,
                        color: Theme.of(context).primaryColor,
                        size: 22,
                      ),
                      onTap: () {
                        Get.toNamed('/sessoes');
                      },
                    ),
                  ),
                  Divider(
                    height: 5,
                    color: Theme.of(context).primaryColor,
                  ),
                  Container(
                    child: ListTile(
                      contentPadding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                      dense: true,
                      title: Text(
                        'Comunicados',
                        style: GoogleFonts.montserrat(
                          color: Theme.of(context).primaryColor,
                          fontSize: 12,
                        ),
                      ),
                      leading: Icon(
                        Icons.notification_add,
                        color: Theme.of(context).primaryColor,
                        size: 22,
                      ),
                      onTap: () {
                        Get.toNamed('/sobre');
                      },
                    ),
                  ),
                  Divider(
                    height: 5,
                    color: Theme.of(context).primaryColor,
                  ),
                  Container(
                    child: ListTile(
                      contentPadding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                      dense: true,
                      title: Text(
                        'Ajuda',
                        style: GoogleFonts.montserrat(
                          color: Theme.of(context).primaryColor,
                          fontSize: 12,
                        ),
                      ),
                      leading: Icon(
                        Icons.help,
                        color: Theme.of(context).primaryColor,
                        size: 22,
                      ),
                      onTap: () {
                        homeController.abrirWhatsApp();
                      },
                    ),
                  ),
                  Divider(
                    height: 5,
                    color: Theme.of(context).primaryColor,
                  ),
                  Container(
                    child: ListTile(
                      contentPadding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                      dense: true,
                      title: Text(
                        'Sair',
                        style: GoogleFonts.montserrat(
                          color: Theme.of(context).primaryColor,
                          fontSize: 12,
                        ),
                      ),
                      leading: Icon(
                        Icons.exit_to_app,
                        color: Theme.of(context).primaryColor,
                        size: 22,
                      ),
                      onTap: () {
                        // logoutUser();
                      },
                    ),
                  ),
                  Divider(
                    height: 15,
                    color: Theme.of(context).primaryColor,
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(top: 60, bottom: 5),
                      child: Container(
                        //color: Color(0xfff5f5f5),
                        child: Image.asset(
                          'images/logo.png',
                          width: 80,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          'Versão 1.0.0',
                          style: GoogleFonts.montserrat(
                            color: Theme.of(context).primaryColor,
                            fontSize: 9,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).accentColor,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Comunicados',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Terapias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Agenda',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: onItemTapped,
      ),
      body: bottomNavigationList[selectedIndex],
    );
  }
}
