import 'package:flutter/material.dart';
import 'package:music_finder/screens/home/home.dart';
import 'package:music_finder/screens/signup/signup.dart';
import 'package:music_finder/screens/root/root.dart';
import 'package:music_finder/services/authentication.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => RootPage(auth: new Auth(),));
      case '/home':
        return MaterialPageRoute(
          builder: (_) => HomePage(),
        );
        break;
      case '/signup':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => SignUpPage(),
          );
        }
      /*return _errorRoute();
      default:
        return _errorRoute();*/
    }
  }

  /*static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }*/
}
