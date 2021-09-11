import 'package:assistsaude/modules/Agenda/agenda_controller.dart';
import 'package:assistsaude/shared/alert_button_pressed.dart';
import 'package:assistsaude/shared/circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AgendarVisitas extends StatefulWidget {
  @override
  _AgendarVisitasState createState() => _AgendarVisitasState();
}

class _AgendarVisitasState extends State<AgendarVisitas> {
  AgendaController agendaController = Get.put(AgendaController());

  void dropDownFavoriteSelected(String novoItem) {
    agendaController.firstId.value = novoItem;
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Agendar Visitas',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Theme.of(context).textSelectionTheme.selectionColor,
              ),
            ),
            centerTitle: true,
          ),
          body: Obx(() {
            return agendaController.isLoading.value
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
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor!,
                                width: 1,
                              ),
                            ),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              underline: Container(),
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size: 27,
                              ),
                              iconEnabledColor: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              dropdownColor: Theme.of(context).primaryColor,
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                              ),
                              items: agendaController.tipos
                                  .map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text("$dropDownStringItem semanas"),
                                );
                              }).toList(),
                              onChanged: (String? novoItemSelecionado) {
                                dropDownFavoriteSelected(novoItemSelecionado!);
                                agendaController.itemSelecionado.value =
                                    novoItemSelecionado;
                              },
                              value: agendaController.itemSelecionado.value,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                              child: CheckboxListTile(
                                  title: Text(
                                    "Domingo",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor,
                                    ),
                                  ),
                                  value: agendaController.checkeddom.value,
                                  onChanged: (newValue) {
                                    agendaController.checkeddom.value =
                                        newValue!;
                                  },
                                  activeColor: Theme.of(context).buttonColor,
                                  controlAffinity:
                                      ListTileControlAffinity.platform)),
                          Container(
                              child: CheckboxListTile(
                            title: Text(
                              "Segunda",
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                              ),
                            ),
                            value: agendaController.checkedseg.value,
                            onChanged: (newValue) {
                              agendaController.checkedseg.value = newValue!;
                            },
                            controlAffinity: ListTileControlAffinity.platform,
                            activeColor: Theme.of(context)
                                .buttonColor, //  <-- platform Checkbox
                          )),
                          Container(
                              child: CheckboxListTile(
                            title: Text(
                              "Terça",
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                              ),
                            ),
                            value: agendaController.checkedter.value,
                            onChanged: (newValue) {
                              agendaController.checkedter.value = newValue!;
                            },
                            activeColor: Theme.of(context).buttonColor,
                            controlAffinity: ListTileControlAffinity
                                .platform, //  <-- platform Checkbox
                          )),
                          Container(
                              child: CheckboxListTile(
                            title: Text(
                              "Quarta",
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                              ),
                            ),
                            value: agendaController.checkedqua.value,
                            onChanged: (newValue) {
                              agendaController.checkedqua.value = newValue!;
                            },
                            activeColor: Theme.of(context).buttonColor,
                            controlAffinity: ListTileControlAffinity
                                .platform, //  <-- platform Checkbox
                          )),
                          Container(
                              child: CheckboxListTile(
                            title: Text(
                              "Quinta",
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                              ),
                            ),
                            value: agendaController.checkedqui.value,
                            onChanged: (newValue) {
                              agendaController.checkedqui.value = newValue!;
                            },
                            activeColor: Theme.of(context).buttonColor,
                            controlAffinity: ListTileControlAffinity
                                .platform, //  <-- platform Checkbox
                          )),
                          Container(
                              child: CheckboxListTile(
                            title: Text(
                              "Sexta",
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                              ),
                            ),
                            value: agendaController.checkedsex.value,
                            onChanged: (newValue) {
                              agendaController.checkedsex.value = newValue!;
                            },
                            activeColor: Theme.of(context).buttonColor,
                            controlAffinity: ListTileControlAffinity
                                .platform, //  <-- platform Checkbox
                          )),
                          Container(
                              child: CheckboxListTile(
                            title: Text(
                              "Sábado",
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                              ),
                            ),
                            value: agendaController.checkedsab.value,
                            onChanged: (newValue) {
                              agendaController.checkedsab.value = newValue!;
                            },
                            activeColor: Theme.of(context).buttonColor,
                            controlAffinity: ListTileControlAffinity
                                .platform, //  <-- platform Checkbox
                          )),
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
                                    return Theme.of(context).accentColor;
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
                              onPressed: () {
                                print(agendaController.idcliente.value);
                                agendaController
                                    .getAgendarVisitas()
                                    .then((value) {
                                  if (value == 1) {
                                    print('ola');
                                    // edgeAlertWidgetTop(
                                    //   context,
                                    //   'Agendamento Realizado com Sucesso!',
                                    // );
                                    Get.offNamed('/visualizar_agenda');
                                    // Get.toNamed('/visualizar_agenda');
                                  } else if (value == "qtdvazio") {
                                    // edgeAlertWidgetDangerTop(
                                    //     context, 'Selecione Qtd de Semanas!');
                                  } else if (value == "diasvazio") {
                                    // edgeAlertWidgetDangerTop(context,
                                    //     'Selecione pelo menos um dia da semana!');
                                  } else {
                                    onAlertButtonPressed(
                                      context,
                                      'Algo deu errado\n Tente novamente',
                                      () {
                                        Get.back();
                                      },
                                    );
                                  }
                                });
                              },
                              child: Text(
                                "Agendar",
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
