import 'package:assistsaude/modules/Agenda/calendario_controller.dart';
import 'package:assistsaude/modules/Agenda/mapa_calendario.dart';
import 'package:assistsaude/modules/MapaAgenda/mapa_agenda_controller.dart';
import 'package:assistsaude/shared/circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class VisualizarAgenda extends StatelessWidget {
  final CalendarioController calendarioController =
      Get.put(CalendarioController());
  final MapaAgendaController mapaAgendaController =
      Get.put(MapaAgendaController());

  Widget buildEventsMarker(context, DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSameDay(calendarioController.selectedDay.value, date)
            ? Colors.blue[800]
            : Theme.of(context).hintColor,
      ),
      width: 18.0,
      height: 18.0,
      child: Center(
        child: Text('${events.length}',
            style: TextStyle().copyWith(
              color: Colors.white,
              fontSize: 14.0,
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var today = DateTime.now();
    var lastday = today.add(const Duration(days: 90));
    var firstday = today.subtract(const Duration(days: 90));

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Agenda',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Theme.of(context).textSelectionTheme.selectionColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              calendarioController.agenda().then((value) => value);
            },
            icon: Icon(
              Icons.refresh_outlined,
              color: Theme.of(context).textSelectionTheme.selectionColor,
            ),
          )
        ],
      ),
      backgroundColor: Theme.of(context).hintColor,
      body: Obx(
        () {
          return calendarioController.isLoading.value
              ? CircularProgressIndicatorWidget()
              : SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          child: TableCalendar(
                            locale: 'pt_BR',
                            firstDay: firstday,
                            lastDay: lastday, //DateTime(2030),
                            focusedDay: calendarioController.focusedDay.value,
                            availableGestures: AvailableGestures.all,
                            startingDayOfWeek: StartingDayOfWeek.sunday,
                            eventLoader: calendarioController.getEventsfromDay,
                            headerStyle: HeaderStyle(
                              titleTextStyle: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                  fontWeight: FontWeight.w600),
                              formatButtonVisible: false,
                              leftChevronIcon: Icon(
                                Icons.chevron_left,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor, // Cor da seta esquerda
                              ),
                              rightChevronIcon: Icon(
                                Icons.chevron_right,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor, // Cor da seta direita
                              ),
                              titleCentered: true,
                            ),
                            calendarBuilders: CalendarBuilders(
                              markerBuilder: (context, date, events) {
                                if (events.isNotEmpty) {
                                  return Positioned(
                                    right: 4,
                                    top: 2,
                                    child: buildEventsMarker(
                                        context, date, events),
                                  );
                                }
                                return Container();
                              },
                            ),
                            daysOfWeekStyle: DaysOfWeekStyle(
                              weekdayStyle: TextStyle(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                              ),
                              weekendStyle: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            calendarStyle: CalendarStyle(
                              outsideDaysVisible: true,
                              todayDecoration: BoxDecoration(
                                color: Colors.red[900],
                                shape: BoxShape.circle,
                              ),
                              defaultTextStyle: TextStyle(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                              ),
                              weekendTextStyle: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                              holidayTextStyle: TextStyle(
                                color: Colors.green,
                              ),
                              selectedTextStyle: TextStyle(
                                color: Colors.black,
                              ),
                              selectedDecoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            calendarFormat: calendarioController.calendarFormat,
                            onDaySelected: (selectedDay, focusedDay) {
                              calendarioController.onSelected.value = true;

                              if (!isSameDay(selectedDay,
                                  calendarioController.selectedDay.value)) {
                                calendarioController.selectedDay.value =
                                    selectedDay;
                                calendarioController.focusedDay.value =
                                    focusedDay;
                              }

                              if (calendarioController.events[
                                          calendarioController
                                              .selectedDay.value] ==
                                      null &&
                                  calendarioController.selectedDay.value
                                      .isAfter(calendarioController.day!)) {
                                // Get.toNamed('/addReservas');
                              }
                            },
                            selectedDayPredicate: (DateTime date) {
                              return isSameDay(
                                  calendarioController.selectedDay.value, date);
                            },
                          ),
                        ),
                        ...calendarioController
                            .getEventsfromDay(
                          calendarioController.selectedDay.value,
                        )
                            .map((MapaEvento e) {
                          // print(e.infocheckin);
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: (e.ctlCheckin == "0" &&
                                          e.ctlCheckout == "0") &&
                                      (e.infoCheck == "0" &&
                                          e.infoCheckout == "0")
                                  ? Colors.amber
                                  : (e.ctlCheckin == "1" && e.ctlCheckout == "0") &&
                                          (e.infoCheck == "0" &&
                                              e.infoCheckout == "0")
                                      ? Colors.red[400]
                                      : (e.ctlCheckin == "1" &&
                                                  e.ctlCheckout == "1") &&
                                              (e.infoCheck == "0" &&
                                                  e.infoCheckout == "0")
                                          ? Colors.green[400]
                                          : (e.ctlCheckin == "1" &&
                                                      e.ctlCheckout == "1") &&
                                                  (e.infoCheck == "1" &&
                                                      e.infoCheckout == "0")
                                              ? Colors.blue[400]
                                              : (e.ctlCheckin == "1" &&
                                                          e.ctlCheckout ==
                                                              "1") &&
                                                      (e.infoCheck == "0" &&
                                                          e.infoCheckout == "1")
                                                  ? Colors.blue[400]
                                                  : (e.ctlCheckin == "1" &&
                                                              e.ctlCheckout ==
                                                                  "1") &&
                                                          (e.infoCheck == "1" &&
                                                              e.infoCheckout ==
                                                                  "1")
                                                      ? Colors.grey
                                                      : Colors.white,
                            ),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            child: ListTile(
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  e.evolcao != ""
                                      ? Icon(
                                          Icons.e_mobiledata,
                                          color: Colors.black,
                                          size: 22,
                                        )
                                      : Container(),
                                  SizedBox(width: 5),
                                  e.hragenda == "00:00"
                                      ? Icon(
                                          Icons.hourglass_empty,
                                          color: Colors.black,
                                          size: 20,
                                        )
                                      : Text(
                                          "${e.hragenda}h",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87),
                                        ),
                                ],
                              ),
                              title: Text(
                                e.paciente!,
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                              ),
                              subtitle: RichText(
                                text: TextSpan(
                                  style: GoogleFonts.montserrat(
                                      fontSize: 10, color: Colors.black87),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: '${e.logradouro} - ${e.bairro}',
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              onTap: () {
                                var latLng = e.latlng!.split(',');
                                var lat = double.parse(latLng[0]);
                                var lng = double.parse(latLng[1]);

                                mapaAgendaController.lat.value = lat;
                                mapaAgendaController.lng.value = lng;
                                mapaAgendaController.name.value = e.paciente!;
                                mapaAgendaController.adress.value =
                                    e.logradouro!;
                                mapaAgendaController.district.value = e.bairro!;
                                mapaAgendaController.uf.value = e.uf!;
                                mapaAgendaController.city.value = e.cidade!;
                                mapaAgendaController.ctlcheckin.value =
                                    e.ctlCheckin!;
                                mapaAgendaController.ctlcheckout.value =
                                    e.ctlCheckout!;
                                mapaAgendaController.infocheckin.value =
                                    e.infoCheck!;
                                mapaAgendaController.infocheckout.value =
                                    e.infoCheckout!;
                                mapaAgendaController.idSessao.value =
                                    e.idsecao!;
                                mapaAgendaController.idPaciente.value =
                                    e.idpac!;
                                mapaAgendaController.dtagenda.value =
                                    e.dtAgenda!;
                                mapaAgendaController.checkin.value = e.checkin!;
                                mapaAgendaController.checkout.value =
                                    e.checkout!;
                                mapaAgendaController.obs.value = e.obs!;
                                mapaAgendaController.evolcao.value = e.evolcao!;

                                var temp = DateTime.now();

                                var d1 = DateTime.utc(
                                    temp.year, temp.month, temp.day);

                                var data = DateTime.parse(e.dtAgenda!);
                                var d2 = DateTime.utc(
                                    data.year, data.month, data.day);

                                if ((e.ctlCheckin == '0' ||
                                        e.ctlCheckout == '0') &&
                                    (d2.compareTo(d1) == 0)) {
                                  mapaAgendaController.getClientes();
                                  Get.toNamed('/mapaAgenda');
                                } else if ((e.ctlCheckin != '1' ||
                                        e.ctlCheckout != '1') &&
                                    d2.compareTo(d1) > 0) {
                                  Get.toNamed('/agendarhorario');

                                  // Get.toNamed('/agendarhorario');
                                } else if ((d2.compareTo(d1) < 0) &&
                                    (e.ctlCheckin == '0' ||
                                        e.ctlCheckout == '0')) {
                                  Get.toNamed('/infoCheck');

                                  // Get.toNamed('/infoCheck');
                                } else if (d2.compareTo(d1) < 0 &&
                                    (e.ctlCheckin == '1' &&
                                        e.ctlCheckout == '1')) {
                                  print(mapaAgendaController.evolcao.value);
                                  Get.toNamed('/detalhesvisitas');
                                  // Get.toNamed('/detalhesvisitas');
                                } else {
                                  Get.toNamed('/detalhesvisitas');

                                  // Get.toNamed('/detalhesvisitas');
                                }
                              },
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
