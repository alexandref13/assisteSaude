import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget customTextField(
    BuildContext context,
    String labelText,
    String hintText,
    bool linesBool,
    int lines,
    bool enabled,
    TextEditingController controller,
    bool autofocus) {
  return TextField(
    autofocus: autofocus,
    onTap: () {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
        currentFocus.focusedChild!.unfocus();
      }
    },
    maxLength: linesBool ? 300 : null,
    controller: controller,
    maxLines: linesBool ? lines : 1,
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
    ),
  );
}
