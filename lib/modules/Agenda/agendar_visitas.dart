import 'package:assistsaude/modules/Agenda/agenda_controller.dart';
import 'package:assistsaude/modules/Agenda/calendario_controller.dart';
import 'package:assistsaude/modules/Login/login_controller.dart';
import 'package:assistsaude/shared/alert_button_pressed.dart';
import 'package:assistsaude/shared/circular_progress_indicator.dart';
import 'package:assistsaude/shared/confirmed_button_pressed.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AgendarVisitas extends StatefulWidget {
  @override
  _AgendarVisitasState createState() => _AgendarVisitasState();
}

class _AgendarVisitasState extends State<AgendarVisitas> {
  AgendaController agendaController = Get.put(AgendaController());
  LoginController loginController = Get.find(tag: 'login');
  CalendarioController calendarioController = Get.put(CalendarioController());

  void dropDownFavoriteSelected(String novoItem) {
    agendaController.firstId.value = novoItem;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            actions: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.send_outlined,
                      size: 20,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor!,
                    ),
                    onPressed: () {
                      print(agendaController.idcliente.value);
                      agendaController.getAgendarVisitas().then((value) {
                        if (value == 1) {
                          confirmedButtonPressed(
                            context,
                            'Agendamento Realizado com Sucesso!',
                            () async {
                              await calendarioController.agenda();
                              loginController.selectedIndex.value = 3;
                              Get.offAllNamed('/home');
                            },
                          );
                        } else if (value == "diasvazio") {
                          onAlertButtonPressed(
                              context, 'Selecione pelo menos um dia da semana!',
                              () {
                            Get.back();
                          });
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
                  ),
                ],
              )
            ],
            title: Text(
              'Agendar Atendimentos',
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
                      margin: EdgeInsets.fromLTRB(5, 10, 5, 50),
                      padding: EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: -2,
                            child: Container(
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
                                dropdownColor: Theme.of(context).hintColor,
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
                                  dropDownFavoriteSelected(
                                      novoItemSelecionado!);
                                  agendaController.itemSelecionado.value =
                                      novoItemSelecionado;
                                },
                                value: agendaController.itemSelecionado.value,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Expanded(
                            flex: -2,
                            child: Container(
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
                                  activeColor: Theme.of(context).primaryColor,
                                  fillColor:
                                      MaterialStateColor.resolveWith((states) {
                                    if (states
                                        .contains(MaterialState.selected)) {
                                      return Theme.of(context)
                                          .primaryColor; // Cor do quadrado quando selecionado
                                    } else {
                                      return Colors
                                          .grey; // Cor do quadrado quando não selecionado
                                    }
                                  }),
                                  controlAffinity:
                                      ListTileControlAffinity.platform),
                            ),
                          ),
                          Divider(
                            color: Theme.of(context).primaryColor,
                          ),
                          Expanded(
                            flex: -2,
                            child: Container(
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
                                controlAffinity:
                                    ListTileControlAffinity.platform,
                                fillColor:
                                    MaterialStateColor.resolveWith((states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return Theme.of(context)
                                        .primaryColor; // Cor do quadrado quando selecionado
                                  } else {
                                    return Colors
                                        .grey; // Cor do quadrado quando não selecionado
                                  }
                                }),
                                activeColor: Theme.of(context)
                                    .primaryColor, //  <-- platform Checkbox
                              ),
                            ),
                          ),
                          Divider(
                            color: Theme.of(context).primaryColor,
                          ),
                          Expanded(
                            flex: -2,
                            child: Container(
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
                              activeColor: Theme.of(context).primaryColor,
                              fillColor:
                                  MaterialStateColor.resolveWith((states) {
                                if (states.contains(MaterialState.selected)) {
                                  return Theme.of(context)
                                      .primaryColor; // Cor do quadrado quando selecionado
                                } else {
                                  return Colors
                                      .grey; // Cor do quadrado quando não selecionado
                                }
                              }),
                              controlAffinity: ListTileControlAffinity
                                  .platform, //  <-- platform Checkbox
                            )),
                          ),
                          Divider(
                            color: Theme.of(context).primaryColor,
                          ),
                          Expanded(
                            flex: -2,
                            child: Container(
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
                              activeColor: Theme.of(context).primaryColor,
                              fillColor:
                                  MaterialStateColor.resolveWith((states) {
                                if (states.contains(MaterialState.selected)) {
                                  return Theme.of(context)
                                      .primaryColor; // Cor do quadrado quando selecionado
                                } else {
                                  return Colors
                                      .grey; // Cor do quadrado quando não selecionado
                                }
                              }),
                              controlAffinity: ListTileControlAffinity
                                  .platform, //  <-- platform Checkbox
                            )),
                          ),
                          Divider(
                            color: Theme.of(context).primaryColor,
                          ),
                          Expanded(
                            flex: -2,
                            child: Container(
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
                              activeColor: Theme.of(context).primaryColor,
                              fillColor:
                                  MaterialStateColor.resolveWith((states) {
                                if (states.contains(MaterialState.selected)) {
                                  return Theme.of(context)
                                      .primaryColor; // Cor do quadrado quando selecionado
                                } else {
                                  return Colors
                                      .grey; // Cor do quadrado quando não selecionado
                                }
                              }),
                              controlAffinity: ListTileControlAffinity
                                  .platform, //  <-- platform Checkbox
                            )),
                          ),
                          Divider(
                            color: Theme.of(context).primaryColor,
                          ),
                          Expanded(
                            flex: -2,
                            child: Container(
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
                              activeColor: Theme.of(context).primaryColor,
                              fillColor:
                                  MaterialStateColor.resolveWith((states) {
                                if (states.contains(MaterialState.selected)) {
                                  return Theme.of(context)
                                      .primaryColor; // Cor do quadrado quando selecionado
                                } else {
                                  return Colors
                                      .grey; // Cor do quadrado quando não selecionado
                                }
                              }),
                              controlAffinity: ListTileControlAffinity
                                  .platform, //  <-- platform Checkbox
                            )),
                          ),
                          Divider(
                            color: Theme.of(context).primaryColor,
                          ),
                          Expanded(
                            flex: -2,
                            child: Container(
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
                              activeColor: Theme.of(context).primaryColor,
                              fillColor:
                                  MaterialStateColor.resolveWith((states) {
                                if (states.contains(MaterialState.selected)) {
                                  return Theme.of(context)
                                      .primaryColor; // Cor do quadrado quando selecionado
                                } else {
                                  return Colors
                                      .grey; // Cor do quadrado quando não selecionado
                                }
                              }),
                              controlAffinity: ListTileControlAffinity
                                  .platform, //  <-- platform Checkbox
                            )),
                          ),
                          Divider(
                            color: Theme.of(context).primaryColor,
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
                              onPressed: () {
                                print(agendaController.idcliente.value);
                                agendaController
                                    .getAgendarVisitas()
                                    .then((value) {
                                  if (value == 1) {
                                    confirmedButtonPressed(
                                      context,
                                      'Agendamento Realizado com Sucesso!',
                                      () async {
                                        await calendarioController.agenda();
                                        loginController.selectedIndex.value = 3;
                                        Get.offAllNamed('/home');
                                      },
                                    );
                                  } else if (value == "qtdvazio") {
                                    onAlertButtonPressed(
                                        context, 'Selecione Qtd de Semanas!',
                                        () {
                                      Get.back();
                                    });
                                  } else if (value == "diasvazio") {
                                    onAlertButtonPressed(context,
                                        'Selecione pelo menos um dia da semana!',
                                        () {
                                      Get.back();
                                    });
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
