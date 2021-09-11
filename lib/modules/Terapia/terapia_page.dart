import 'package:assistsaude/modules/Terapia/terapia_controller.dart';
import 'package:assistsaude/shared/box_search.dart';
import 'package:assistsaude/shared/circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TerapiaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TerapiaController terapiaController = Get.put(TerapiaController());

    return Scaffold(
      body: Obx(
        () {
          return terapiaController.isLoading.value
              ? CircularProgressIndicatorWidget()
              : SafeArea(
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          child: boxSearch(
                            context,
                            terapiaController.search.value,
                            terapiaController.onSearchTextChanged,
                            "Pesquise os Comunicados...",
                          ),
                        ),
                        Expanded(
                          child: terapiaController.searchResult.isNotEmpty ||
                                  terapiaController.search.value.text.isNotEmpty
                              ? Container(
                                  padding: EdgeInsets.all(8),
                                  child: RefreshIndicator(
                                    onRefresh: terapiaController.onRefresh,
                                    child: ListView.builder(
                                      itemCount:
                                          terapiaController.searchResult.length,
                                      itemBuilder: (_, i) {
                                        var terapias =
                                            terapiaController.searchResult[i];
                                        return Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            color:
                                                Theme.of(context).primaryColor,
                                            child: ListTile(
                                              title: Container(
                                                child: Text(
                                                  terapias.nomepac!,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 12,
                                                      color: Theme.of(context)
                                                          .textSelectionTheme
                                                          .selectionColor,
                                                      fontWeight:
                                                          FontWeight.bold),
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
                                )
                              : Container(
                                  padding: EdgeInsets.all(8),
                                  child: RefreshIndicator(
                                    onRefresh: terapiaController.onRefresh,
                                    child: ListView.builder(
                                      itemCount:
                                          terapiaController.terapias.length,
                                      itemBuilder: (_, i) {
                                        var terapias =
                                            terapiaController.terapias[i];
                                        return Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            color:
                                                Theme.of(context).primaryColor,
                                            child: ListTile(
                                              title: Container(
                                                child: Text(
                                                  terapias.nomepac!,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 12,
                                                      color: Theme.of(context)
                                                          .textSelectionTheme
                                                          .selectionColor,
                                                      fontWeight:
                                                          FontWeight.bold),
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
