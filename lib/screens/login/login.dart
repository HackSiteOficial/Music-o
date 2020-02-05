import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final welcome = Hero(
      tag: 'hero',
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text.rich(
            TextSpan(
              text: 'Bienvenido de Nuevo \n',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0
              ),// default text style
              children: <TextSpan>[
                TextSpan(
                  text: 'Inicia Sesion',
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
        // child: Image.asset('assets/logo2.png'),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        labelText: 'Correo Electronico',
        labelStyle: TextStyle(
            color: Colors.white
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: BorderSide(
              color: Colors.white, width: 1.0
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: BorderSide(
              color: Colors.white, width: 1.0
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: BorderSide(
              color: Colors.red, width: 1.0
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: BorderSide(
              color: Colors.red, width: 1.0
          ),
        ),
      ),
      style: TextStyle(
          color: Colors.white
      ),
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
            }
        ),
        labelStyle: TextStyle(
            color: Colors.white
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0)
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: BorderSide(
              color: Colors.white, width: 1.0
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: BorderSide(
              color: Colors.white, width: 1.0
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: BorderSide(
              color: Colors.red, width: 1.0
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: BorderSide(
              color: Colors.red, width: 1.0
          ),
        ),
      ),
      style: TextStyle(
          color: Colors.white
      ),
    );

    final forgotLabel = FlatButton(
      padding: EdgeInsets.all(0.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          '¿Olvidaste tu contraseña?',
          style: TextStyle(color: Colors.white70),
        ),
      ),
      onPressed: () {},
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 50.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          //side: BorderSide(color: Colors.grey)
        ),
        onPressed: () {
          Navigator.of(context).pushNamed('/second',
              arguments: 'Home');
        },
        padding: EdgeInsets.all(12),
        color: Colors.grey,
        child: Text('Iniciar Sesión', style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 30.0, right: 30.0),
          children: <Widget>[
            welcome,
            SizedBox(height: 50.0),
            email,
            SizedBox(height: 25.0),
            password,
            SizedBox(height: 5.0),
            forgotLabel,
            SizedBox(height: 30.0),
            loginButton
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
