import 'package:flutter/material.dart';
import 'package:music_finder/util/state_widget.dart';
import 'package:music_finder/screens/login/redirector.dart';
import 'package:music_finder/screens/login/sign_in.dart';
import 'package:music_finder/screens/login/sign_up.dart';
import 'package:music_finder/screens/login/forgot_password.dart';

class MyApp extends StatelessWidget {
  MyApp() {
    //Navigation.initPaths();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => Redirector(),
        '/signin': (context) => SignIn(),
        '/signup': (context) => SignUp(),
        '/forgot-password': (context) => ForgotPassword(),
      },
    );
  }
}

void main() {
  StateWidget stateWidget = new StateWidget(
    child: new MyApp(),
  );
  runApp(stateWidget);
}