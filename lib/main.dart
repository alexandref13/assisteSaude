import 'package:assistsaude/modules/Comunicados/components/detalhes_comunicados_page.dart';
import 'package:assistsaude/modules/Comunicados/comunicados.dart';
import 'package:assistsaude/modules/Home/home_page.dart';
import 'package:assistsaude/modules/Login/components/list_of_clients_page.dart';
import 'package:assistsaude/modules/Senha/senha.dart';
import 'package:assistsaude/modules/Terapia/components/DetalhesTerapia/detalhes_terapia_page.dart';
import 'package:assistsaude/modules/Terapia/terapia_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'modules/Session/session_page.dart';
import 'theme/theme.dart';
import 'modules/Login/login_bindings.dart';
import 'modules/Login/login_page.dart';

void main() {
  runApp(
    GetMaterialApp(
      localizationsDelegates: [
        RefreshLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale('pt')],
      initialRoute: '/login',
      debugShowCheckedModeBanner: false,
      theme: admin,
      getPages: [
        GetPage(
          name: '/login',
          page: () => LoginPage(),
          binding: LoginBinding(),
        ),
        GetPage(
          name: '/home',
          page: () => HomePage(),
        ),
        GetPage(
          name: '/comunicados',
          page: () => Comunicados(),
        ),
        GetPage(
          name: '/detalhesComunicados',
          page: () => DetalhesComunicadosPage(),
        ),
        GetPage(
          name: '/terapia',
          page: () => TerapiaPage(),
        ),
        GetPage(
          name: '/visitas',
          page: () => SessionPage(),
        ),
        GetPage(
          name: '/listOfClients',
          page: () => ListOfClients(),
        ),
        GetPage(
          name: '/senha',
          page: () => Senha(),
        ),
        GetPage(
          name: '/detalhesTerapia',
          page: () => DetalhesTerapiaPage(),
        ),
      ],
    ),
  );
}
