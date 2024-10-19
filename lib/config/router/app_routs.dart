import 'package:flutter/material.dart';

import '../../features/Tasaks/presentation/pages/task_page.dart';
import '../../features/splash/splash_page.dart';
import 'name_routs.dart';

class AppRouts {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NameRouts.splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case NameRouts.task:
        return MaterialPageRoute(builder: (_) => const TaskPage());
      default:
        return onUnknownRoute(settings);
    }
  }

  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Center(
          child: Text('No route defined for ${settings.name}'),
        ),
      );
    });
  }
}
