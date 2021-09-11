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
      body: terapiaController.isLoading.value
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
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: ListView(
                          children: [
                            Container(
                                padding: EdgeInsets.only(bottom: 30),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  color: Theme.of(context).primaryColor,
                                  child: ListTile(
                                    leading: RichText(
                                      text: TextSpan(
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: '11' + "  ",
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(
                                            text: 'Set' + ' ',
                                            style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor,
                                                letterSpacing: 2),
                                          ),
                                          TextSpan(
                                            text: '21' + ' ',
                                            style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    title: Container(
                                      child: Center(
                                        child: Text(
                                          'Paciente',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor,
                                              fontWeight: FontWeight.bold),
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
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
