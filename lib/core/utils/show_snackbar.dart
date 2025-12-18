import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    //using hideCurrentSnackBar() to hide the previous snackbar
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}
