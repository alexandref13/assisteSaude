import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

onAlertButtonPressed(context, String text, VoidCallback onTap) {
  Alert(
    image: Icon(
      Icons.close,
      color: Theme.of(context).errorColor,
      size: 50,
    ),
    style: AlertStyle(
      backgroundColor: Theme.of(context).textSelectionTheme.selectionColor,
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      //descStyle: GoogleFonts.poppins(color: Colors.red,),
      animationDuration: Duration(milliseconds: 300),
      titleStyle: GoogleFonts.poppins(
        color: Theme.of(context).errorColor,
        fontSize: 16,
      ),
    ),
    context: context,
    title: text,
    buttons: [
      DialogButton(
        child: Text(
          "OK",
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        onPressed: onTap,
        width: 80,
        color: Theme.of(context).errorColor,
      )
    ],
  ).show();
}
