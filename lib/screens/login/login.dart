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
      resizeToAvoidBottomPadding: false,
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
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/back2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 60.0),
                  children: <Widget>[
                    showLogo(),
                    showEmailInput(),
                    showPasswordInput(),
                    showPrimaryButton(),
                    showSecondarySign(),
                    showErrorMessage(),
                  ],
            ),
          ))));
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
    return _isLoginForm
        ? Hero(
            tag: 'hero',
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text.rich(
                  TextSpan(
                    text: "Music'o \n",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Entra',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 60.0,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : Hero(
            tag: 'hero',
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text.rich(
                  TextSpan(
                    text: "Eres Nuevo \n",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Registrate',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 60.0,
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
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        maxLines: 1,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.email, color: Colors.white),
          labelText: 'Correo Electronico',
          hasFloatingPlaceholder: false,
          contentPadding: EdgeInsetsDirectional.only(bottom: 16.0),
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
        style: TextStyle(color: Colors.white),
        validator: (value) =>
            value.isEmpty ? 'El correo no puede quedar vacio' : null,
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showPasswordInput() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.1,
        child: TextFormField(
          autofocus: false,
          obscureText: true,
          maxLines: 1,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock_outline, color: Colors.white),
            labelText: 'Contraseña',
            hasFloatingPlaceholder: false,
            contentPadding: EdgeInsetsDirectional.only(bottom: 16.0),
            labelStyle: TextStyle(color: Colors.white),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
          style: TextStyle(color: Colors.white),
          validator: (value) =>
              value.isEmpty ? 'La contraseña no puede quedar vacio' : null,
          onSaved: (value) => _password = value.trim(),
        ));
  }

  void _setAgreedToTOS(bool newValue) {
    setState(() {
      _agreedToTOS = newValue;
    });
  }

  Widget forgotLabel() {
    return _isLoginForm
        ? FlatButton(
            padding: EdgeInsets.all(0.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                '¿Olvidaste tu contraseña?',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            onPressed: () {},
          )
        : Padding(
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
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          style: BorderStyle.solid,
          width: 2.0,
        ),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: RaisedButton(
            elevation: 0.0,
            color: Colors.transparent,
            padding: EdgeInsets.all(12),
            onPressed: validateAndSubmit,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(_isLoginForm ? 'INICIA SESION' : 'REGISTRATE',
                  style: TextStyle(fontSize: 14.0, color: Colors.white)),
            ),
          )),
    );
  }

  Widget showSecondaryButton() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      child: FlatButton(
        padding: EdgeInsets.only(top: 20.0),
        child: Align(
            alignment: Alignment.centerLeft,
            child: _isLoginForm
                ? Text(
                    'REGISTRATE',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 12.0,
                    ),
                  )
                : Text.rich(
                    TextSpan(
                      text: 'Ya tienes cuenta, ',
                      style: TextStyle(color: Colors.white70, fontSize: 14.0),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Inicia Sesión',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  )),
        onPressed: toggleFormMode,
      ),
    );
  }

  Widget showSecondarySign() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton(
            padding: EdgeInsets.only(top: 20.0),
            child: _isLoginForm
                ? Text(
                    'REGISTRATE',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 12.0,
                    ),
                  )
                : Text(
                    'INICIA SESION',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 12.0,
                    ),
                  ),
            onPressed: toggleFormMode,
          ),
          Row(
            children: <Widget>[
              _isLoginForm
                  ? FlatButton(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '¿Olvidaste tu contraseña?',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                      onPressed: () {},
                    )
                  : Text('')
            ],
          ),
        ],
      ),
    );
  }
}
