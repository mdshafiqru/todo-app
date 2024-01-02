import 'package:flutter/material.dart';

class AppConfig {
  static const devMode = true;
  static const isLoggedIn = false;
  static const logErrors = true;
}

showSnackBar({required BuildContext context, required String message}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(content: Text(message)),
    );
}
