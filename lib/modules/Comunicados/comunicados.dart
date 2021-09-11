import 'package:assistsaude/modules/Comunicados/comunicados_controller.dart';
import 'package:assistsaude/shared/box_search.dart';
import 'package:assistsaude/shared/circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Comunicados extends StatelessWidget {
  final ComunicadosController comunicadosController =
      Get.put(ComunicadosController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return comunicadosController.isLoading.value
              ? CircularProgressIndicatorWidget()
              : SafeArea(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Container(
                          child: boxSearch(
                            context,
                            comunicadosController.search.value,
                            comunicadosController.onSearchTextChanged,
                            "Pesquise os Comunicados...",
                          ),
                        ),
                        Expanded(
                          child: comunicadosController
                                      .searchResult.isNotEmpty ||
                                  comunicadosController
                                      .search.value.text.isNotEmpty
                              ? Container(
                                  padding: EdgeInsets.all(8),
                                  child: RefreshIndicator(
                                    onRefresh: comunicadosController.onRefresh,
                                    child: ListView.builder(
                                        itemCount: comunicadosController
                                            .searchResult.length,
                                        itemBuilder: (context, index) {
                                          var comunicados =
                                              comunicadosController
                                                  .searchResult[index];
                                          return GestureDetector(
                                            onTap: () {
                                              comunicadosController.title
                                                  .value = comunicados.titulo;
                                              comunicadosController
                                                      .description.value =
                                                  comunicados.descricao;

                                              Get.toNamed(
                                                  '/detalhesComunicados');
                                            },
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              child: ListTile(
                                                leading: RichText(
                                                  text: TextSpan(
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 12,
                                                      color: Theme.of(context)
                                                          .textSelectionTheme
                                                          .selectionColor,
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text:
                                                              comunicados.dia +
                                                                  "  ",
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                      TextSpan(
                                                        text: comunicados.mes +
                                                            ' ',
                                                        style: GoogleFonts.montserrat(
                                                            fontSize: 14,
                                                            color: Theme.of(
                                                                    context)
                                                                .textSelectionTheme
                                                                .selectionColor,
                                                            letterSpacing: 2),
                                                      ),
                                                      TextSpan(
                                                        text: comunicados.ano +
                                                            ' ',
                                                        style: GoogleFonts.montserrat(
                                                            fontSize: 14,
                                                            color: Theme.of(
                                                                    context)
                                                                .textSelectionTheme
                                                                .selectionColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                title: Container(
                                                  child: Center(
                                                    child: Text(
                                                      comunicados.titulo,
                                                      style: GoogleFonts.montserrat(
                                                          fontSize: 12,
                                                          color: Theme.of(
                                                                  context)
                                                              .textSelectionTheme
                                                              .selectionColor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                trailing: Icon(
                                                  Icons.arrow_right,
                                                  color: Theme.of(context)
                                                      .textSelectionTheme
                                                      .selectionColor,
                                                  size: 26,
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ))
                              : RefreshIndicator(
                                  onRefresh: comunicadosController.onRefresh,
                                  child: ListView.builder(
                                    itemCount: comunicadosController
                                        .comunicados.length,
                                    itemBuilder: (context, index) {
                                      var comunicados = comunicadosController
                                          .comunicados[index];

                                      return GestureDetector(
                                        onTap: () {
                                          comunicadosController.title.value =
                                              comunicados.titulo!;
                                          comunicadosController.description
                                              .value = comunicados.descricao!;

                                          Get.toNamed('/detalhesComunicados');
                                        },
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          color: Theme.of(context).primaryColor,
                                          child: ListTile(
                                            leading: RichText(
                                              text: TextSpan(
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 12,
                                                    color: Theme.of(context)
                                                        .textSelectionTheme
                                                        .selectionColor),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: comunicados.dia! +
                                                          "  ",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                  TextSpan(
                                                    text:
                                                        comunicados.mes! + ' ',
                                                    style: GoogleFonts.montserrat(
                                                        fontSize: 14,
                                                        color: Theme.of(context)
                                                            .textSelectionTheme
                                                            .selectionColor,
                                                        letterSpacing: 2),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        comunicados.ano! + ' ',
                                                    style: GoogleFonts.montserrat(
                                                        fontSize: 14,
                                                        color: Theme.of(context)
                                                            .textSelectionTheme
                                                            .selectionColor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            title: Container(
                                              child: Center(
                                                child: Text(
                                                  comunicados.titulo!,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 12,
                                                      color: Theme.of(context)
                                                          .textSelectionTheme
                                                          .selectionColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            trailing: Icon(
                                              Icons.arrow_right,
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor,
                                              size: 26,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
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
