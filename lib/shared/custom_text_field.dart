import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';

Widget customTextField(
    BuildContext context,
    String labelText,
    String hintText,
    bool linesBool,
    int lines,
    bool enabled,
    TextEditingController controller,
    bool autofocus,
    int caracteres) {
  return SingleChildScrollView(
    child: TextField(
      autofocus: autofocus,
      textAlignVertical: TextAlignVertical.center,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild!.unfocus();
        }
      },
      maxLength: linesBool ? caracteres : null,
      controller: controller,
      maxLines: linesBool ? lines : 1,

      keyboardType: TextInputType
          .visiblePassword, // ADICIONADO PARA BLOQUEAR A ENTRADA VIA COLA
      textInputAction: TextInputAction
          .newline, // adicionado para permitir que o usuário pressione a tecla "return" ou "enter"

      onChanged: (text) {
        if (text.contains(RegExp(
            r'[^\s\w\-()áéíóúâêîôûãõàèìòùäëïöüçñ{}\[\]\s":;.?/,<>+=˜`!@\\\\|\#$%ˆ&*_-]'))) {
          // Verifica se há caracteres especiais no texto
          Flushbar(
            flushbarPosition: FlushbarPosition.TOP,
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
            titleText: Text(
              "AÇÃO NÃO PERMITIDA!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Theme.of(context).textSelectionTheme.selectionColor,
              ),
            ),
            messageText: Text(
              "A colagem de texto não é permitida para a descrição clínica.",
              style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).textSelectionTheme.selectionColor),
            ),
          )..show(context);
          controller.clear(); // Limpa o texto se houver caracteres especiais
        }
      },
      style: GoogleFonts.montserrat(
        fontSize: 14,
        color: Theme.of(context).textSelectionTheme.selectionColor!,
      ),
      decoration: InputDecoration(
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Theme.of(context).textSelectionTheme.selectionColor!,
            width: 1,
          ),
        ),
        enabled: enabled,
        hintText: hintText,
        hintStyle: GoogleFonts.montserrat(
          fontSize: 14,
          color: Theme.of(context).textSelectionTheme.selectionColor!,
        ),
        labelText: labelText,
        labelStyle: GoogleFonts.montserrat(
          fontSize: 14,
          color: Theme.of(context).textSelectionTheme.selectionColor!,
        ),
        isDense: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Theme.of(context).textSelectionTheme.selectionColor!,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Theme.of(context).textSelectionTheme.selectionColor!,
            width: 1,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    ),
  );
}
