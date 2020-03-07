import 'package:flutter/material.dart';
import 'package:music_finder/router.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Music'o",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/profile',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

