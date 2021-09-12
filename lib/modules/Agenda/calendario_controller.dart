import 'package:assistsaude/modules/Agenda/api_calendario.dart';
import 'package:assistsaude/modules/Agenda/mapa_calendario.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class CalendarioController extends GetxController {
  var isLoading = true.obs;
  var onSelected = false.obs;

  Map<DateTime, List<MapaEvento>> events = {};

  List<dynamic>? selectedEvents;

  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime now = DateTime.now();
  DateTime? day;
  var focusedDay = DateTime.now().obs;
  var selectedDay = DateTime.now().obs;

  List<MapaEvento> getEventsfromDay(DateTime date) {
    return events[date] ?? [];
  }

  agenda() async {
    isLoading(true);

    var response = await ApiCalendario.getCalendario();

    var dados = json.decode(response.body);

    if (dados != null) {
      for (var eventos in dados) {
        events
            .putIfAbsent(
                DateTime.parse('${eventos['dt_agenda']} 00:00:00.000Z'),
                () => [])
            .add(
              MapaEvento(
                confdata: eventos['confdata'],
                paciente: eventos['paciente'],
                logradouro: eventos['logradouro'],
                bairro: eventos['bairro'],
                cidade: eventos['cidade'],
                uf: eventos['uf'],
                ctlGps: eventos['ctl_gps'],
                idsecao: eventos['idsecao'],
                idpftr: eventos['idpftr'],
                obs: eventos['obs'],
                idStatus: eventos['id_status'],
                dtAgenda: eventos['dt_agenda'],
                checkin: eventos['checkin'],
                checkout: eventos['checkout'],
                ctlCheckin: eventos['ctl_checkin'],
                ctlCheckout: eventos['ctl_checkout'],
                infoCheck: eventos['info_check'],
                infoCheckout: eventos['info_checkout'],
                latlng: eventos['latlng'],
              ),
            );
      }
    }
    isLoading(false);
  }

  init() {
    var date = DateFormat('yyyy-MM-dd').format(selectedDay.value);

    var newSelectedDay = DateTime.parse('$date 00:00:00.000Z');

    selectedDay.value = newSelectedDay;

    day = DateTime(now.year, now.month, now.day - 1);
  }

  @override
  void onInit() {
    init();
    agenda();
    super.onInit();
  }
}
