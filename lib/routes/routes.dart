import 'package:flutter/material.dart';

import '../views/views.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const Home());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              ErrorScreen(errorMessage: 'Route not found: ${settings.name}'),
        );
    }
  }
}
