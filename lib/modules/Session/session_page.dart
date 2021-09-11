import 'package:assistsaude/modules/Session/session_controller.dart';
import 'package:assistsaude/shared/alert_button_pressed.dart';
import 'package:assistsaude/shared/circular_progress_indicator.dart';
import 'package:assistsaude/shared/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SessionPage extends StatefulWidget {
  @override
  _SessionPageState createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  final SessionController sessionController = Get.put(SessionController());

  void dropDownClientsSelected(String novoItem) {
    sessionController.firstId.value = novoItem;
  }

  DateTime? startSelectedDate;
  TimeOfDay? startSelectedTime;
  DateTime? endSelectedDate;
  TimeOfDay? endSelectedTime;
  var startTime = TextEditingController();
  var endTime = TextEditingController();

  selectDateTime(BuildContext context) => showDatePicker(
        context: context,
        initialDate: DateTime.now().add(Duration(seconds: 1)),
        firstDate: DateTime(2021),
        lastDate: DateTime(2030),
      );

  selectDateOnEndTime(BuildContext context) => showDatePicker(
        context: context,
        initialDate: startSelectedDate!,
        firstDate: startSelectedDate!,
        lastDate: DateTime(2100),
      );

  @override
  void initState() {
    startSelectedDate = DateTime.now();
    startSelectedTime = TimeOfDay.now();
    endSelectedDate = DateTime.now();
    endSelectedTime = TimeOfDay.now();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Visitas',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Theme.of(context).textSelectionTheme.selectionColor,
          ),
        ),
      ),
      body: Obx(
        () {
          return sessionController.isLoading.value
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
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor!),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ButtonTheme(
                            height: 50.0,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    return Theme.of(context).accentColor;
                                  },
                                ),
                                elevation:
                                    MaterialStateProperty.resolveWith<double>(
                                  (Set<MaterialState> states) {
                                    return 0;
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
                              onPressed: () {},
                              child: DropdownButton<String>(
                                autofocus: false,
                                isExpanded: true,
                                underline: Container(),
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 27,
                                ),
                                dropdownColor: Theme.of(context).primaryColor,
                                style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor),
                                items: sessionController.clientes.map((item) {
                                  return DropdownMenuItem(
                                    value: item['idcliente'].toString(),
                                    child: Text(item['nomecliente']),
                                  );
                                }).toList(),
                                onChanged: (String? novoItemSelecionado) {
                                  dropDownClientsSelected(novoItemSelecionado!);
                                  sessionController.firstId.value =
                                      novoItemSelecionado;
                                },
                                value: sessionController.firstId.value,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 8,
                          ),
                          child: Text(
                            'Data Inicial: ',
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
                              startSelectedDate = await selectDateTime(context);
                              if (startSelectedDate == null) return;

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
                              DateFormat("dd/MM/yyyy").format(
                                startSelectedDate!,
                              ),
                              DateFormat("dd/MM/yyyy").format(
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
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 8,
                          ),
                          child: Text(
                            'Data Final: ',
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
                              endSelectedDate =
                                  await selectDateOnEndTime(context);
                              if (endSelectedDate == null) return;
                              setState(() {
                                endSelectedDate = DateTime(
                                  endSelectedDate!.year,
                                  endSelectedDate!.month,
                                  endSelectedDate!.day,
                                  endSelectedTime!.hour,
                                  endSelectedTime!.minute,
                                );
                              });
                            },
                            child: customTextField(
                              context,
                              DateFormat("dd/MM/yyyy").format(
                                endSelectedDate!,
                              ),
                              DateFormat("dd/MM/yyyy").format(
                                endSelectedDate!,
                              ),
                              false,
                              1,
                              false,
                              endTime,
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
                              sessionController.initialDate.value =
                                  DateFormat("yyyy-MM-dd").format(
                                startSelectedDate!,
                              );
                              sessionController.finalDate.value =
                                  DateFormat('yyyy-MM-dd').format(
                                endSelectedDate!,
                              );

                              if (startSelectedDate == DateTime.now() ||
                                  endSelectedDate == DateTime.now()) {
                                onAlertButtonPressed(
                                    context, 'Campo Obrigátorio Vazio', () {
                                  Get.back();
                                });
                              } else {
                                await sessionController.doRelatorios(context);
                              }
                            },
                            child: Text(
                              "Enviar",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
