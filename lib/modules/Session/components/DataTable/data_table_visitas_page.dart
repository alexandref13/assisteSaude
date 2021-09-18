import 'package:assistsaude/modules/Session/components/DataTable/data_table_visitas_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DataTableVisitas extends StatelessWidget {
  final DataTableController dataTableController =
      Get.put(DataTableController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Paciente',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Theme.of(context).textSelectionTheme.selectionColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            child: DataTable(
                sortColumnIndex: 0,
                sortAscending: true,
                columns: [
                  DataColumn(
                    label: Text(
                      'DATA',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'CLIENTE',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'CHECK-IN',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'CHECK-OUT',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'TEMPO',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
                rows: dataTableController.data
                    .map(
                      (item) => DataRow(
                        color: MaterialStateColor.resolveWith((states) {
                          return item['info_checkin'] == '0' &&
                                  item['info_checkout'] == '0'
                              ? Colors.green
                              : (item['info_checkin'] == '1' &&
                                          item['info_checkout'] == '0') ||
                                      (item['info_checkin'] == '0' &&
                                          item['info_checkout'] == '1')
                                  ? Colors.blue
                                  : Colors.grey[700]!;
                        }),
                        cells: <DataCell>[
                          DataCell(
                            Text(
                              item['dt_agenda'],
                              style: GoogleFonts.montserrat(fontSize: 14),
                            ),
                          ),
                          DataCell(
                            Text(
                              item['paciente'],
                              style: GoogleFonts.montserrat(fontSize: 14),
                            ),
                          ),
                          DataCell(
                            Text(
                              item['checking'],
                              style: GoogleFonts.montserrat(fontSize: 14),
                            ),
                          ),
                          DataCell(
                            Text(
                              item['checkout'],
                              style: GoogleFonts.montserrat(fontSize: 14),
                            ),
                          ),
                          DataCell(
                            Text(
                              item['tempo'],
                              style: GoogleFonts.montserrat(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList()),
          ),
        ),
      ),
    );
  }
}
