import 'package:flutter/material.dart';
import 'package:music_finder/services/authentication.dart';

class LoginSignupPage extends StatefulWidget {
  LoginSignupPage({this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;

  @override
  State<StatefulWidget> createState() => new _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _errorMessage;
  bool _agreedToTOS = false;
  bool _isLoginForm;
  bool _isLoading;

  // Check if form is valid before perform login or signup
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login or signup
  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (validateAndSave()) {
      String userId = "";
      try {
        if (_isLoginForm) {
          userId = await widget.auth.signIn(_email, _password);
          print('Signed in: $userId');
        } else {
          userId = await widget.auth.signUp(_email, _password);
          //widget.auth.sendEmailVerification();
          //_showVerifyEmailSentDialog();
          print('Signed up user: $userId');
        }
        setState(() {
          _isLoading = false;
        });

        if (userId.length > 0 && userId != null && _isLoginForm) {
          widget.loginCallback();
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    _isLoginForm = true;
    super.initState();
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  void toggleFormMode() {
    resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Stack(
          children: <Widget>[
            _showForm(),
            _showCircularProgress(),
          ],
        ));
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

//  void _showVerifyEmailSentDialog() {
//    showDialog(
//      context: context,
//      builder: (BuildContext context) {
//        // return object of type Dialog
//        return AlertDialog(
//          title: new Text("Verify your account"),
//          content:
//              new Text("Link to verify account has been sent to your email"),
//          actions: <Widget>[
//            new FlatButton(
//              child: new Text("Dismiss"),
//              onPressed: () {
//                toggleFormMode();
//                Navigator.of(context).pop();
//              },
//            ),
//          ],
//        );
//      },
//    );
//  }

  Widget _showForm() {
    return new Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 60.0),
              children: <Widget>[
                showLogo(),
                SizedBox(height: 120.0),
                showEmailInput(),
                SizedBox(height: 25.0),
                showPasswordInput(),
                SizedBox(height: 5.0),
                forgotLabel(),
                SizedBox(height: 30.0),
                showPrimaryButton(),
                SizedBox(height: 30.0),
                showSecondaryButton(),
                showErrorMessage(),
              ],
            ),
          )
        )
    );
  }

  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget showLogo() {
    return new Hero(
      tag: 'hero',
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text.rich(
            TextSpan(
              text: 'Bienvenido de Nuevo \n',
              style: TextStyle(
                  color: Colors.white, fontSize: 16.0), // default text style
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
      ),
    );
  }

  Widget showEmailInput() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      maxLines: 1,
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
      validator: (value) => value.isEmpty ? 'El correo no puede quedar vacio' : null,
      onSaved: (value) => _email = value.trim(),
    );
  }

  Widget showPasswordInput() {
    return TextFormField(
      autofocus: false,
      obscureText: true,
      maxLines: 1,
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
      validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
      onSaved: (value) => _password = value.trim(),
    );
  }

  void _setAgreedToTOS(bool newValue) {
    setState(() {
      _agreedToTOS = newValue;
    });
  }

  Widget forgotLabel() {
    return _isLoginForm ? FlatButton(
      padding: EdgeInsets.all(0.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          '¿Olvidaste tu contraseña?',
          style: TextStyle(color: Colors.white70),
        ),
      ),
      onPressed: () {},
    ) : Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
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
                child: Text(
                  'Aceptar terminos y condiciones',
                  style: TextStyle(color: Colors.white70, fontSize: 14.0),
                ),
              ),
            ],
          ),
        ));
  }

  Widget showPrimaryButton() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 50.0),
          child: RaisedButton(
            color: Colors.grey,
            padding: EdgeInsets.all(12),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24)),
            child: Text(_isLoginForm ? 'Iniciar Sesion' : 'Registrate',
                style: TextStyle(fontSize: 14.0, color: Colors.white)),
            onPressed: validateAndSubmit,
          ),
        );
  }

  Widget showSecondaryButton() {
    return FlatButton(
      padding: EdgeInsets.only(top: 20.0),
      child: Align(
        alignment: Alignment.center,
        child: _isLoginForm ? Text.rich(
          TextSpan(
            text: 'Aun no tienes cuenta, ',
            style: TextStyle(
                color: Colors.white70, fontSize: 14.0),
            children: <TextSpan>[
              TextSpan(
                text: 'Registrate',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ) : Text(''),
      ),
      onPressed: toggleFormMode,
    );
  }

}