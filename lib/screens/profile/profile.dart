import 'package:flutter/material.dart';
import 'package:music_finder/services/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:music_finder/model/todo.dart';
import 'dart:async';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget head() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            width: MediaQuery.of(context).size.width * 0.4,
            child: Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  text: "NOMBRE \n",
                  style: TextStyle(color: Colors.grey, fontSize: 12.0, letterSpacing: 1.5),
                  children: [
                    TextSpan(
                      text: 'Saúl\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24.0,
                        height: 1.5
                      ),
                    ),
                    WidgetSpan(
                      child: Icon(Icons.star, size: 16, color: Colors.white),
                    ),
                    TextSpan(
                      text: ' 23',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        height: 3
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            height: 200,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image(
                  image: AssetImage('assets/perfil.jpg')
                )
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget info() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 20.0, top: 20.0),
        child: Text(
          'INFORMACION',
          style: TextStyle(color: Colors.grey, fontSize: 12.0, letterSpacing: 1.5),
        ),
      )
    );
  }

  Widget infoBio() {
    return Container(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'Hello World! Soy Saúl, fan de las películas y los videojuegos, idealista, hacker, y este es mi hogar.',
            style: TextStyle(color: Colors.white, fontSize: 14.0, letterSpacing: 1.5),
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('PERFIL', textAlign: TextAlign.center, style: TextStyle(letterSpacing: 6),),
//          actions: <Widget>[
//            new FlatButton(
//                child: new Text('Logout',
//                    style: new TextStyle(fontSize: 17.0, color: Colors.white)),
//                onPressed: signOut)
//          ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            head(),
            info(),
            infoBio(),
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
        },
        tooltip: 'Increment',
        child: Icon(Icons.edit, color: Colors.black),
      ));
  }
}
