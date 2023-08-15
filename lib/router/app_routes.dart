import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart' show MenuOption;
import 'package:movies_app/screens/home_screen.dart';

class AppRoutes {
  static const initialRoute = 'home';

  static final menuOptions = <MenuOption>[];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};

    for (var el in menuOptions) {
      appRoutes.addAll({el.route: (BuildContext context) => el.screen});
    }
    return appRoutes;
  }

  static MaterialPageRoute<dynamic> Function(dynamic) onGenerateRoute =
      (settings) {
    return MaterialPageRoute(
      builder: (context) => const HomeScreen(),
    );
  };
}
