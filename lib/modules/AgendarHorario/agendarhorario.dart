import 'package:assistsaude/modules/AgendarHorario/agendarhorario.controller.dart';
import 'package:assistsaude/shared/circular_progress_indicator.dart';
import 'package:assistsaude/shared/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AgendarHorario extends StatefulWidget {
  @override
  _AgendarHorarioState createState() => _AgendarHorarioState();
}

class _AgendarHorarioState extends State<AgendarHorario> {
  //const AgendarHorario({ Key? key }) : super(key: key);
  final AgendaHorarioController agendahorarioController =
      Get.put(AgendaHorarioController());

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
            child: child!);
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
    agendahorarioController.hour.value.text =
        "${startSelectedTime!.hour.toString()}:${startSelectedTime!.minute.toString()}";
    // print(infoCheckController.hour.value.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Agendar Horário',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Theme.of(context).textSelectionTheme.selectionColor,
              ),
            ),
            centerTitle: true,
          ),
          body: Obx(() {
            return agendahorarioController.isLoading.value
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
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 8,
                            ),
                            child: Text(
                              'Hora da Visita:',
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
                                agendahorarioController.hour.value.text =
                                    "${startSelectedTime!.hour.toString()}:${startSelectedTime!.minute.toString()}";
                                await agendahorarioController
                                    .changeHours(context);
                              },
                              child: Text(
                                "Incluir",
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
