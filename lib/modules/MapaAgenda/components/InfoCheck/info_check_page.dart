import 'package:assistsaude/shared/alert_button_pressed.dart';
import 'package:assistsaude/shared/circular_progress_indicator.dart';
import 'package:assistsaude/shared/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../mapa_agenda_controller.dart';
import 'info_check_controller.dart';

class InfoCheckPage extends StatefulWidget {
  @override
  _InfoCheckPageState createState() => _InfoCheckPageState();
}

class _InfoCheckPageState extends State<InfoCheckPage> {
  final InfoCheckController infoCheckController =
      Get.put(InfoCheckController());
  final MapaAgendaController mapaAgendaController =
      Get.put(MapaAgendaController());

  DateTime? startSelectedDate;
  TimeOfDay? startSelectedTime;
  DateTime? endSelectedDate;
  TimeOfDay? endSelectedTime;
  var startTime = TextEditingController();
  var endTime = TextEditingController();

  selectTime(BuildContext context) {
    final now = DateTime.now();
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
      builder: (BuildContext? context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context!).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
  }

  selectEndTime(BuildContext context) {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 23, minute: 59),
      builder: (BuildContext? context, Widget? child) {
        return MediaQuery(
            data: MediaQuery.of(context!).copyWith(alwaysUse24HourFormat: true),
            child: child!);
      },
    );
  }

  @override
  void initState() {
    startSelectedDate = DateTime.now();
    startSelectedTime = TimeOfDay.now();
    endSelectedDate = DateTime.now();
    endSelectedTime = TimeOfDay.now();
    infoCheckController.hour.value.text =
        "${startSelectedTime!.hour.toString()}:${startSelectedTime!.minute.toString()}";
    print(infoCheckController.hour.value.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Informe o Horário',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Theme.of(context).textSelectionTheme.selectionColor,
              ),
            ),
            centerTitle: true,
          ),
          body: Obx(() {
            return infoCheckController.isLoading.value
                ? CircularProgressIndicatorWidget()
                : SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      padding: EdgeInsets.all(8),
                      height: MediaQuery.of(context).size.height * .95,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          mapaAgendaController.ctlcheckin.value == '0'
                              ? Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5,
                                    vertical: 8,
                                  ),
                                  child: Text(
                                    'Hora Entrada:',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor,
                                    ),
                                  ),
                                )
                              : Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5,
                                    vertical: 8,
                                  ),
                                  child: Text(
                                    'Hora Saída:',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor,
                                    ),
                                  ),
                                ),
                          Container(
                            child: GestureDetector(
                              onTap: () async {
                                startSelectedTime = await selectTime(context);
                                if (startSelectedTime == null) return;

                                setState(() {
                                  startSelectedDate = DateTime(
                                    startSelectedDate!.year,
                                    startSelectedDate!.month,
                                    startSelectedDate!.day,
                                    startSelectedTime!.hour,
                                    startSelectedTime!.minute,
                                  );
                                });
                              },
                              child: customTextField(
                                context,
                                DateFormat("HH:mm").format(
                                  startSelectedDate!,
                                ),
                                DateFormat("HH:mm").format(
                                  startSelectedDate!,
                                ),
                                false,
                                1,
                                false,
                                startTime,
                                false,
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          SizedBox(
                            height: 30,
                          ),
                          ButtonTheme(
                            height: 50.0,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    return Theme.of(context).primaryColor;
                                  },
                                ),
                                shape: MaterialStateProperty.resolveWith<
                                    OutlinedBorder>(
                                  (Set<MaterialState> states) {
                                    return RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    );
                                  },
                                ),
                              ),
                              onPressed: () async {
                                //var now = new DateTime.now();
                                //print(new DateFormat("yyyy-MM-dd").format(now));
                                // calcular com hora e minutos
                                var horaSel;
                                var minutoSel;
                                var monthSel = "";
                                var daySel = "";

                                infoCheckController.hour.value.text =
                                    "${startSelectedTime!.hour.toString()}:${startSelectedTime!.minute.toString()}";

                                var hourSel =
                                    int.parse("${startSelectedTime!.hour}");
                                var minuteSel =
                                    int.parse("${startSelectedTime!.minute}");

                                if (hourSel < 10) {
                                  horaSel = "0${startSelectedTime!.hour}";
                                } else {
                                  horaSel = "${startSelectedTime!.hour}";
                                }

                                if (minuteSel < 10) {
                                  minutoSel = "0${startSelectedTime!.minute}";
                                } else {
                                  minutoSel = "${startSelectedTime!.minute}";
                                }

                                if (minuteSel < 10) {
                                  minutoSel = "0${startSelectedTime!.minute}";
                                } else {
                                  minutoSel = "${startSelectedTime!.minute}";
                                }

                                if (startSelectedDate!.month < 10) {
                                  monthSel = "0${startSelectedDate!.month}";
                                } else {
                                  monthSel = "${startSelectedDate!.month}";
                                }
                                if (startSelectedDate!.day < 10) {
                                  daySel = "0${startSelectedDate!.day}";
                                } else {
                                  daySel = "${startSelectedDate!.day}";
                                }

                                var hora =
                                    "${startSelectedDate!.year}-$monthSel-$daySel $horaSel:$minutoSel";

                                print('hora: $hora');

                                var temp = DateTime.now();

                                var d1 = DateTime.utc(temp.year, temp.month,
                                    temp.day, temp.hour, temp.minute);

                                var data = DateTime.parse(hora);
                                var dt =
                                    DateFormat("yyyy-MM-dd HH:mm").format(data);

                                var data2 = DateTime.parse(dt);
                                var d2 = DateTime.utc(data2.year, data2.month,
                                    data2.day, data2.hour, data2.minute);
                                print('D1=$d1');
                                // termina aqui

                                // Calcular apenas a DATA

                                var temp2 =
                                    "${mapaAgendaController.dtagenda.value}";
                                var dataAg = DateTime.parse(temp2);

                                var dataAgenda = DateTime.utc(
                                    dataAg.year, dataAg.month, dataAg.day);

                                var dataRaiz =
                                    "${startSelectedDate!.year}-$monthSel-$daySel";
                                var dataRaizDate = DateTime.parse(dataRaiz);

                                var dataInformada = DateTime.utc(
                                    dataRaizDate.year,
                                    dataRaizDate.month,
                                    dataRaizDate.day);

                                //print(dataInformada);
                                //print('ola $dataAgenda2');

                                if (d2.compareTo(d1) > 0 &&
                                    (dataInformada.compareTo(dataAgenda)) <=
                                        0) {
                                  onAlertButtonPressed(
                                    context,
                                    'Horário não permitido!\nMaior que o atual',
                                    () {
                                      Get.back();
                                    },
                                  );
                                } else {
                                  print('foi');
                                  await infoCheckController
                                      .changeHours(context);
                                }
                              },
                              child: Text(
                                "Incluir Horário",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
          })),
    );
  }
}
