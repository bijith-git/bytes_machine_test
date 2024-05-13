import 'package:flutter/material.dart';

class Utils {
  static void showSnackbar(BuildContext context, String message,
      {Widget? content,
      Duration duration = const Duration(seconds: 2),
      SnackBarAction? action}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: content ?? Text(message),
        duration: duration,
        action: action,
      ),
    );
  }
}
