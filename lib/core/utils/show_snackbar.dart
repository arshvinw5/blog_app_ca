import 'package:flutter/material.dart';

void showSnackBar(
  BuildContext context,
  String message, {
  Color? backgroundColor,
  Color? textColor,
  FontWeight? fontWeight,
  double? fontSize,
}) {
  ScaffoldMessenger.of(context)
    //using hideCurrentSnackBar() to hide the previous snackbar
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: textColor,
            fontWeight: fontWeight,
            fontSize: fontSize,
          ),
        ),
        backgroundColor: backgroundColor,
      ),
    );
}
