import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  static String tag = 'signup-page';
  @override
  _SignUpPageState createState() => new _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  bool _agreedToTOS = true;

  @override
  Widget build(BuildContext context) {
    final welcome = Hero(
      tag: 'hero',
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text.rich(
            TextSpan(
              text: 'Eres nuevo? \n',
              style: TextStyle(
                  color: Colors.white, fontSize: 16.0), // default text style
              children: <TextSpan>[
                TextSpan(
                  text: 'Registrate',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 30.0,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    final name = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
        labelText: 'Nombre Completo',
        labelStyle: TextStyle(color: Colors.white),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: BorderSide(color: Colors.white, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: BorderSide(color: Colors.white, width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
      ),
      style: TextStyle(color: Colors.white),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        labelText: 'Correo Electronico',
        labelStyle: TextStyle(color: Colors.white),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: BorderSide(color: Colors.white, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: BorderSide(color: Colors.white, width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
      ),
      style: TextStyle(color: Colors.white),
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Contraseña',
        suffixIcon: IconButton(
            color: Colors.white,
            icon: Icon(Icons.visibility_off),
            onPressed: () {
              debugPrint('222');
            }),
        labelStyle: TextStyle(color: Colors.white),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: BorderSide(color: Colors.white, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: BorderSide(color: Colors.white, width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
      ),
      style: TextStyle(color: Colors.white),
    );

    void _setAgreedToTOS(bool newValue) {
      setState(() {
        _agreedToTOS = newValue;
      });
    }

    final checkbox = Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor: Colors.white,
          ),
          child: Row(
            children: <Widget>[
              Checkbox(
                checkColor: Colors.white,
                activeColor: Colors.black,
                value: _agreedToTOS,
                onChanged: _setAgreedToTOS,
              ),
              GestureDetector(
                onTap: () => _setAgreedToTOS(!_agreedToTOS),
                child: const Text(
                  'Aceptar terminos y condiciones',
                  style: TextStyle(color: Colors.white70, fontSize: 14.0),
                ),
              ),
            ],
          ),
        ));

    final signupButton = Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          //side: BorderSide(color: Colors.grey)
        ),
        onPressed: () {
          Navigator.of(context).pushNamed('/second', arguments: 'Home');
        },
        padding: EdgeInsets.all(12),
        color: Colors.grey,
        child: Text('Registrate', style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ListView(
          padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 60.0),
          children: <Widget>[
            welcome,
            SizedBox(height: 120.0),
            name,
            SizedBox(height: 25.0),
            email,
            SizedBox(height: 25.0),
            password,
            checkbox,
            signupButton,
          ],
        ),
      ),
    );
  }
}

/*
onPressed: () {
Navigator.of(context).pushNamed('/second',
arguments: 'Hello there from the first page!');
},*/

// child: Image.asset('assets/logo2.png'),
