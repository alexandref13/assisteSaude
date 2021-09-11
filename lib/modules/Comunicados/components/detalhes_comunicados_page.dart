import 'package:assistsaude/modules/Comunicados/comunicados_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DetalhesComunicadosPage extends StatelessWidget {
  final ComunicadosController comunicadosController =
      Get.put(ComunicadosController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${comunicadosController.title}',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Theme.of(context).textSelectionTheme.selectionColor,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(16),
        child: Text(
          '${comunicadosController.description}',
          style: GoogleFonts.montserrat(
            fontSize: 14,
            color: Theme.of(context).textSelectionTheme.selectionColor,
          ),
        ),
      ),
    );
  }
}
