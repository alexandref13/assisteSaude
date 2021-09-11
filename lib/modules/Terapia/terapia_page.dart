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
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Container(
                          child: boxSearch(
                            context,
                            terapiaController.search.value,
                            terapiaController.onSearchTextChanged,
                            "Pesquise as terapias...",
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
                                      itemBuilder: (context, index) {
                                        var terapias = terapiaController
                                            .searchResult[index];
                                        return GestureDetector(
                                          onTap: () {},
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            color:
                                                Theme.of(context).primaryColor,
                                            child: ListTile(
                                              title: Text(
                                                terapias.nomepac!,
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 12,
                                                  color: Theme.of(context)
                                                      .textSelectionTheme
                                                      .selectionColor,
                                                  fontWeight: FontWeight.bold,
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
                              : RefreshIndicator(
                                  onRefresh: terapiaController.onRefresh,
                                  child: ListView.builder(
                                    itemCount:
                                        terapiaController.terapias.length,
                                    itemBuilder: (context, index) {
                                      var terapias =
                                          terapiaController.terapias[index];

                                      return GestureDetector(
                                        onTap: () {},
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          color: terapias.ctlaceito == '0'
                                              ? Colors.amber
                                              : terapias.ctlaceito == '1'
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : Colors.red[300],
                                          child: ListTile(
                                            title: Text(
                                              terapias.nomepac!,
                                              style: GoogleFonts.montserrat(
                                                fontSize: 12,
                                                color: terapias.ctlaceito == '0'
                                                    ? Colors.black
                                                    : Theme.of(context)
                                                        .textSelectionTheme
                                                        .selectionColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            trailing: Icon(
                                              Icons.arrow_right,
                                              color: terapias.ctlaceito == '0'
                                                  ? Colors.black
                                                  : Theme.of(context)
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
