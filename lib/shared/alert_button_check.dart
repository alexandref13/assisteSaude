import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

onAlertButtonCheck(context, String? text, String? page) {
  Alert(
    image: Icon(
      Icons.check,
      color: Colors.green,
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
        onPressed: () {
          page != null ? Get.offAllNamed('$page') : Get.back();
        },
        width: 80,
        color: Colors.green,
      )
    ],
  ).show();
}
