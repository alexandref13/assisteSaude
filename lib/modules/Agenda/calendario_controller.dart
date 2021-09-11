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

    if (dados != 0) {
      for (var eventos in dados) {
        events
            .putIfAbsent(DateTime.parse('${eventos['dtagenda']} 00:00:00.000Z'),
                () => [])
            .add(
              MapaEvento(
                idcliente: eventos['idcliente'],
                fantasia: eventos['fantasia'],
                endereco: eventos['endereco'],
                numero: eventos['numero'],
                complemento: eventos['complemento'],
                bairro: eventos['bairro'],
                cidade: eventos['cidade'],
                uf: eventos['uf'],
                ctlgps: eventos['ctlgps'],
                latlng: eventos['latlng'],
                idvisita: eventos['idvisita'],
                checkin: eventos['checkin'],
                checkout: eventos['checkout'],
                ctlcheckin: eventos['ctlcheckin'],
                ctlcheckout: eventos['ctlcheckout'],
                dtagenda: eventos['dtagenda'],
                hragenda: eventos['hragenda'],
                infocheckin: eventos['infocheckin'],
                infocheckout: eventos['infocheckout'],
                obs: eventos['obs'],
              ),
            );
      }
    }
    print(dados);
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
