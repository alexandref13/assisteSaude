import 'package:get/get.dart';
import 'mapa_agenda_controller.dart';

class MapaBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MapaAgendaController(), tag: 'mapaAgenda', permanent: true);
  }
}
