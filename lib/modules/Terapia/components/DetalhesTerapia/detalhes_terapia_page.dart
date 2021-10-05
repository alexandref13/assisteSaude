import 'package:assistsaude/modules/MapaAgenda/mapa_agenda_controller.dart';
import 'package:assistsaude/modules/Terapia/components/DetalhesTerapia/detalhs_terapia_controller.dart';
import 'package:assistsaude/shared/circular_progress_indicator.dart';
import 'package:assistsaude/shared/delete_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DetalhesTerapiaPage extends StatelessWidget {
  final DetalhesTerapiaController detalhesTerapiaController =
      Get.put(DetalhesTerapiaController());
  final MapaAgendaController mapaAgendaController =
      Get.put(MapaAgendaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Paciente',
          style: GoogleFonts.montserrat(
            fontSize: 14,
            color: Theme.of(context).textSelectionTheme.selectionColor,
          ),
        ),
      ),
      body: Obx(
        () {
          return detalhesTerapiaController.isLoading.value
              ? CircularProgressIndicatorWidget()
              : Container(
                  child: ListView.builder(
                    itemCount: detalhesTerapiaController.details.length,
                    itemBuilder: (_, i) {
                      var details = detalhesTerapiaController.details[i];

                      return SingleChildScrollView(
                        child: Container(
                          child: GestureDetector(
                            onTap: () {},
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Icon(
                                  Icons.airline_seat_flat,
                                  size: 35,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Text(
                                    details.nome!,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Center(
                                    child: Text(
                                  '${details.end} - ${details.bairro}',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                  ),
                                )),
                                Center(
                                  child: Text(
                                    '${details.cidade} - ${details.uf}',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor,
                                    ),
                                  ),
                                ),
                                Divider(
                                  height: 40,
                                  thickness: 2,
                                  indent: 20,
                                  endIndent: 20,
                                  color: Theme.of(context).primaryColor,
                                ),
                                Column(
                                  children: [
                                    Center(
                                      child: Text(
                                        'Diagnóstico',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 10, 0),
                                        child: Text(
                                          details.diagnostico!,
                                          style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  height: 40,
                                  thickness: 2,
                                  indent: 20,
                                  endIndent: 20,
                                  color: Theme.of(context).primaryColor,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'Status',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            details.status!,
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Registro',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            details.reg!,
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 40,
                                  thickness: 2,
                                  indent: 20,
                                  endIndent: 20,
                                  color: Theme.of(context).primaryColor,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'Idade',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            details.idade!,
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Convênio',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            details.convenio!,
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 40,
                                  thickness: 2,
                                  indent: 20,
                                  endIndent: 20,
                                  color: Theme.of(context).primaryColor,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () async {
                                                await detalhesTerapiaController
                                                    .makePhoneCall(
                                                        details.tel!, context);
                                              },
                                              child: Card(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 40,
                                                      child: Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(6.0),
                                                          child: Icon(
                                                            Icons.phone,
                                                            color: Theme.of(
                                                                    context)
                                                                .textSelectionTheme
                                                                .selectionColor,
                                                            size: 24,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            'Telefone',
                                                            style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .textSelectionTheme
                                                                  .selectionColor,
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () async {
                                                await detalhesTerapiaController
                                                    .makePhoneCall(
                                                        details.cel!, context);
                                              },
                                              child: Card(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 40,
                                                      child: Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(6.0),
                                                          child: Icon(
                                                            Icons.phone_iphone,
                                                            size: 24,
                                                            color: Theme.of(
                                                                    context)
                                                                .textSelectionTheme
                                                                .selectionColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            'Celular',
                                                            style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .textSelectionTheme
                                                                  .selectionColor,
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                detalhesTerapiaController
                                                    .abrirWhatsApp(
                                                  details.cel!,
                                                  context,
                                                );
                                              },
                                              child: Card(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 40,
                                                      child: Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(6.0),
                                                          child: Image.asset(
                                                            'images/whatsapp.png',
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            'Whatsapp',
                                                            style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .textSelectionTheme
                                                                  .selectionColor,
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () async {
                                                var newLatLng =
                                                    details.latlng!.split(',');

                                                mapaAgendaController.lat.value =
                                                    double.parse(newLatLng[0]);
                                                mapaAgendaController.lng.value =
                                                    double.parse(newLatLng[1]);
                                                mapaAgendaController
                                                    .name.value = details.nome!;

                                                mapaAgendaController
                                                        .adress.value =
                                                    '${details.end} ${details.bairro}\n${details.cidade} - ${details.uf}';

                                                await mapaAgendaController
                                                    .getClientes();

                                                Get.toNamed('/mapapage');

                                                //await detalhesTerapiaController.goToMap(details.latlng!);
                                              },
                                              child: Card(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 40,
                                                      child: Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(6.0),
                                                          child: Icon(
                                                            Icons.map,
                                                            size: 24,
                                                            color: Theme.of(
                                                                    context)
                                                                .textSelectionTheme
                                                                .selectionColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            'Mapa',
                                                            style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .textSelectionTheme
                                                                  .selectionColor,
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                details.ctlAceito == '0'
                                    ? Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 16,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                ),
                                                child: ButtonTheme(
                                                  height: 50.0,
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .resolveWith<
                                                                  Color>(
                                                        (Set<MaterialState>
                                                            states) {
                                                          return Colors.red;
                                                        },
                                                      ),
                                                      shape: MaterialStateProperty
                                                          .resolveWith<
                                                              OutlinedBorder>(
                                                        (Set<MaterialState>
                                                            states) {
                                                          return RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    onPressed: () async {
                                                      deleteAlert(
                                                        context,
                                                        'Deseja recusar o paciente?',
                                                        () async {
                                                          detalhesTerapiaController
                                                              .ctl.value = '2';
                                                          await detalhesTerapiaController
                                                              .aceitarRecusar();
                                                        },
                                                      );
                                                    },
                                                    child: Text(
                                                      "Recusar",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Theme.of(context)
                                                            .textSelectionTheme
                                                            .selectionColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                ),
                                                child: ButtonTheme(
                                                  height: 50.0,
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .resolveWith<
                                                                  Color>(
                                                        (Set<MaterialState>
                                                            states) {
                                                          return Theme.of(
                                                                  context)
                                                              .primaryColor;
                                                        },
                                                      ),
                                                      shape: MaterialStateProperty
                                                          .resolveWith<
                                                              OutlinedBorder>(
                                                        (Set<MaterialState>
                                                            states) {
                                                          return RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      deleteAlert(
                                                        context,
                                                        'Deseja aceitar o paciente?',
                                                        () async {
                                                          detalhesTerapiaController
                                                              .ctl.value = '1';
                                                          await detalhesTerapiaController
                                                              .aceitarRecusar();
                                                        },
                                                      );
                                                    },
                                                    child: Text(
                                                      "Aceitar",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Theme.of(context)
                                                            .textSelectionTheme
                                                            .selectionColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 16,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                ),
                                                child: ButtonTheme(
                                                  height: 50.0,
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .resolveWith<
                                                                  Color>(
                                                        (Set<MaterialState>
                                                            states) {
                                                          return Colors.red;
                                                        },
                                                      ),
                                                      shape: MaterialStateProperty
                                                          .resolveWith<
                                                              OutlinedBorder>(
                                                        (Set<MaterialState>
                                                            states) {
                                                          return RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    onPressed: () async {
                                                      Get.toNamed('infoStatus');
                                                    },
                                                    child: Text(
                                                      "Info Status",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Theme.of(context)
                                                            .textSelectionTheme
                                                            .selectionColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                ),
                                                child: ButtonTheme(
                                                  height: 50.0,
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .resolveWith<
                                                                  Color>(
                                                        (Set<MaterialState>
                                                            states) {
                                                          return Theme.of(
                                                                  context)
                                                              .textSelectionTheme
                                                              .selectionColor!;
                                                        },
                                                      ),
                                                      shape: MaterialStateProperty
                                                          .resolveWith<
                                                              OutlinedBorder>(
                                                        (Set<MaterialState>
                                                            states) {
                                                          return RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      Get.toNamed(
                                                          '/agendaVisitas');
                                                    },
                                                    child: Text(
                                                      "Agendar",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
