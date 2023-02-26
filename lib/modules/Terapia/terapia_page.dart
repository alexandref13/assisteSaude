import 'package:assistsaude/modules/Terapia/components/DetalhesTerapia/detalhs_terapia_controller.dart';
import 'package:assistsaude/modules/Terapia/terapia_controller.dart';
import 'package:assistsaude/shared/box_search.dart';
import 'package:assistsaude/shared/circular_progress_indicator.dart';
import 'package:assistsaude/shared/delete_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TerapiaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TerapiaController terapiaController = Get.put(TerapiaController());
    DetalhesTerapiaController detalhesTerapiaController =
        Get.put(DetalhesTerapiaController());
    // CalendarioController calendarioController = Get.put(CalendarioController());

    return /*WillPopScope(
      onWillPop: () async {
        deleteAlert(context, 'Deseja realmente sair?', () {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        });
        return false;
      },
      child: */
        Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Terapias',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Theme.of(context).textSelectionTheme.selectionColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              terapiaController.getTerapias().then((value) => value);
            },
            icon: Icon(
              Icons.refresh_outlined,
              color: Theme.of(context).textSelectionTheme.selectionColor,
            ),
          )
        ],
      ),
      body: Obx(
        () {
          if (terapiaController.isLoading.value == true) {
            return CircularProgressIndicatorWidget();
          } else {
            return terapiaController.terapias.length == 0
                ? Stack(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                          'images/semregistro.png',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 100),
                              //child: Icon(Icons.block, size: 34, color: Colors.red[900]),
                            ),
                            Text(
                              'Sem registros',
                              style: GoogleFonts.montserrat(
                                fontSize: 14.0,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
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
                                    terapiaController
                                        .search.value.text.isNotEmpty
                                ? RefreshIndicator(
                                    onRefresh: terapiaController.onRefresh,
                                    child: ListView.builder(
                                      itemCount:
                                          terapiaController.searchResult.length,
                                      itemBuilder: (context, index) {
                                        var terapias = terapiaController
                                            .searchResult[index];
                                        return GestureDetector(
                                          onTap: () async {
                                            detalhesTerapiaController.idpftr
                                                .value = terapias.idpftr!;

                                            await detalhesTerapiaController
                                                .getDetails();
                                          },
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            color: terapias.ctlaceito == '0' &&
                                                    terapias.idstatus == '1'
                                                ? Colors.amber
                                                : terapias.ctlaceito == '1' &&
                                                        terapias.idstatus == '1'
                                                    ? Theme.of(context)
                                                        .primaryColor
                                                    : terapias.idstatus != '1'
                                                        ? Colors.grey
                                                        : Colors.red[300],
                                            child: ListTile(
                                              leading: Icon(
                                                terapias.idstatus != '1'
                                                    ? Icons
                                                        .not_interested_outlined
                                                    : Icons.person_outline,
                                              ),
                                              title: Text(
                                                terapias.nomepac!,
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 12,
                                                  color: terapias.ctlaceito ==
                                                          '0'
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
                                          onTap: () async {
                                            detalhesTerapiaController.idpftr
                                                .value = terapias.idpftr!;

                                            await detalhesTerapiaController
                                                .getDetails();
                                          },
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            color: terapias.ctlaceito == '0' &&
                                                    terapias.idstatus == '1'
                                                ? Colors.amber
                                                : terapias.ctlaceito == '1' &&
                                                        terapias.idstatus == '1'
                                                    ? Theme.of(context)
                                                        .primaryColor
                                                    : terapias.idstatus != '1'
                                                        ? Colors.grey
                                                        : Colors.red[300],
                                            child: ListTile(
                                              leading: Icon(
                                                terapias.idstatus != '1'
                                                    ? Icons
                                                        .not_interested_outlined
                                                    : Icons.person_outline,
                                              ),
                                              title: Text(
                                                terapias.nomepac!,
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 12,
                                                  color: terapias.ctlaceito ==
                                                          '0'
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
          }
        },
      ),
      //),
    );
  }
}
