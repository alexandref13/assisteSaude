import 'package:assistsaude/modules/MapaAgenda/mapa_agenda_controller.dart';
import 'package:assistsaude/shared/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DetalhesVisita extends StatelessWidget {
  final MapaAgendaController mapaAgendaController =
      Get.put(MapaAgendaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Detalhes da Sessão',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Theme.of(context).textSelectionTheme.selectionColor,
            ),
          ),
          centerTitle: true,
        ),
        body: Obx(() {
          return SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 5),
              padding: EdgeInsets.all(8),
              height: MediaQuery.of(context).size.height * .95,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(Icons.airline_seat_flat,
                      size: 35,
                      color: (mapaAgendaController.infocheckin.value == "0" &&
                              mapaAgendaController.infocheckout.value == "0")
                          ? Colors.green
                          : (mapaAgendaController.infocheckin.value == "0" &&
                                  mapaAgendaController.infocheckout.value ==
                                      "1")
                              ? Colors.blue
                              : (mapaAgendaController.infocheckin.value ==
                                          "1" &&
                                      mapaAgendaController.infocheckout.value ==
                                          "0")
                                  ? Colors.blue
                                  : Colors.grey),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                      child: Text(
                    mapaAgendaController.name.value,
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                  )),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                      child: Text(
                    "${mapaAgendaController.adress.value} ${mapaAgendaController.number.value} - ${mapaAgendaController.district.value}",
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                  )),
                  Center(
                      child: Text(
                    "${mapaAgendaController.city.value} - ${mapaAgendaController.uf.value}",
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                  )),
                  divider(context),
                  Center(
                    child: Text(
                      'Check-in realizado em:',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        color:
                            Theme.of(context).textSelectionTheme.selectionColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 15,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Center(
                        child: Text(
                          "${mapaAgendaController.checkin.value}h",
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      mapaAgendaController.infocheckin.value == "1"
                          ? GestureDetector(
                              onTap: () {
                                mapaAgendaController.ctlcheckin.value = '0';
                                Get.toNamed('/infoCheck');
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.edit,
                                    size: 16,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  divider(context),
                  Center(
                    child: Text(
                      'Check-out realizado às:',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        color:
                            Theme.of(context).textSelectionTheme.selectionColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 15,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Center(
                        child: Text(
                          "${mapaAgendaController.checkout.value}h",
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      mapaAgendaController.infocheckout.value == "1"
                          ? GestureDetector(
                              onTap: () {
                                mapaAgendaController.ctlcheckin.value = '1';
                                Get.toNamed('/infoCheck');
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.edit,
                                    size: 16,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  divider(context),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: customTextField(
                      context,
                      "Observação...",
                      mapaAgendaController.obs.value,
                      true,
                      3,
                      true,
                      mapaAgendaController.observacao.value,
                      true,
                    ),
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
                        shape:
                            MaterialStateProperty.resolveWith<OutlinedBorder>(
                          (Set<MaterialState> states) {
                            return RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            );
                          },
                        ),
                      ),
                      onPressed: () async {
                        await mapaAgendaController.doObs(context);
                      },
                      child: Text(
                        "Enviar Observação",
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
        }));
  }

  Widget divider(context) {
    return Divider(
        height: 40,
        thickness: 2,
        indent: 20,
        endIndent: 20,
        color: (mapaAgendaController.infocheckin.value == "0" &&
                mapaAgendaController.infocheckout.value == "0")
            ? Colors.green
            : (mapaAgendaController.infocheckin.value == "0" &&
                    mapaAgendaController.infocheckout.value == "1")
                ? Colors.blue
                : (mapaAgendaController.infocheckin.value == "1" &&
                        mapaAgendaController.infocheckout.value == "0")
                    ? Colors.blue
                    : Colors.grey);
  }
}
