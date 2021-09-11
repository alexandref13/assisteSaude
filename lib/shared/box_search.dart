import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget boxSearch(BuildContext context, TextEditingController searchController,
    onSearchTextChanged, textopesquisa) {
  return Container(
    padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
    child: TextField(
      onChanged: onSearchTextChanged == '' ? null : onSearchTextChanged,
      controller: searchController,
      style: GoogleFonts.montserrat(
        fontSize: 14,
        color: Theme.of(context).textSelectionTheme.selectionColor,
      ),
      decoration: InputDecoration(
        labelText: textopesquisa,
        labelStyle: GoogleFonts.montserrat(
          fontSize: 12,
          color: Theme.of(context).textSelectionTheme.selectionColor,
        ),
        prefixIcon: Icon(
          Icons.search,
          color: Theme.of(context).textSelectionTheme.selectionColor,
          size: 20,
        ),
        isDense: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).textSelectionTheme.selectionColor!,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).textSelectionTheme.selectionColor!,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );
}
