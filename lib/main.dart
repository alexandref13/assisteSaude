import 'package:assistsaude/modules/Agenda/agendar_visitas.dart';
import 'package:assistsaude/modules/Agenda/detalhes_visita.dart';
import 'package:assistsaude/modules/AgendarHorario/agendarhorario.dart';
import 'package:assistsaude/modules/Comunicados/components/detalhes_comunicados_page.dart';
import 'package:assistsaude/modules/Comunicados/comunicados.dart';
import 'package:assistsaude/modules/Esqueci/esqueci_senha.dart';
import 'package:assistsaude/modules/Home/home_page.dart';
import 'package:assistsaude/modules/Login/components/list_of_clients_page.dart';
import 'package:assistsaude/modules/MapaAgenda/components/InfoCheck/info_check_page.dart';
import 'package:assistsaude/modules/MapaAgenda/mapa_agenda_page.dart';
import 'package:assistsaude/modules/Perfil/perfil.dart';
import 'package:assistsaude/modules/Senha/senha.dart';
import 'package:assistsaude/modules/Terapia/components/DetalhesTerapia/detalhes_terapia_page.dart';
import 'package:assistsaude/modules/Terapia/components/DetalhesTerapia/mapa_page.dart';
import 'package:assistsaude/modules/Terapia/terapia_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'modules/Agenda/visualizar_agenda.dart';
import 'modules/InfoStatus/info_status_page.dart';
import 'modules/Session/components/DataTable/data_table_visitas_page.dart';
import 'modules/Session/session_page.dart';
import 'theme/theme.dart';
import 'modules/Login/login_bindings.dart';
import 'modules/Login/login_page.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter/cupertino.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.setAppId('7e568fea-1c24-4463-a5bc-c5ede3c5c90a');
    // final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      var titulo = result.notification.title;
      print('NOTIFICACAO ABERTA: $titulo');
      if (titulo == 'CONVITE TERAPIA') {
        Get.toNamed('/terapia');
      } else if (titulo == 'Alteração Status') {
        Get.toNamed('/terapia');
      } else if (titulo == 'GPS DE PACIENTE ATUALIZADO') {
        Get.toNamed('/visualizarAgenda');
      } else if (titulo == 'CHECK-IN AUTORIZADO') {
        Get.toNamed('/visualizarAgenda');
      } else if (titulo == 'COMUNICADO') {
        Get.toNamed('/comunicados');
      } else if (titulo == 'Recusa Status') {
        Get.toNamed('/terapia');
      } else if (titulo == 'LOCAL RECUSADO') {
        Get.toNamed('/visualizarAgenda');
      } else {}
    });

    return GetMaterialApp(
      localizationsDelegates: [
        RefreshLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
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
        GetPage(
          name: '/infoStatus',
          page: () => InfoStatusPage(),
        ),
        GetPage(
          name: '/agendaVisitas',
          page: () => AgendarVisitas(),
        ),
        GetPage(
          name: '/visualizarAgenda',
          page: () => VisualizarAgenda(),
        ),
        GetPage(
          name: '/mapaAgenda',
          page: () => MapaAgendaPage(),
        ),
        GetPage(
          name: '/perfil',
          page: () => Perfil(),
        ),
        GetPage(
          name: '/infoCheck',
          page: () => InfoCheckPage(),
        ),
        GetPage(
          name: '/agendarhorario',
          page: () => AgendarHorario(),
        ),
        GetPage(
          name: '/dataTableVisitas',
          page: () => DataTableVisitas(),
        ),
        GetPage(
          name: '/esqueci',
          page: () => Esqueci(),
        ),
        GetPage(
          name: '/mapapage',
          page: () => MapaPage(),
        ),
        GetPage(
          name: '/detalhesvisitas',
          page: () => DetalhesVisita(),
        ),
      ],
    );
  }
}
