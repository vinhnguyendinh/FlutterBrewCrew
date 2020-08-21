import 'package:brew_crew/utils/constant.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  Function switchShowSignIn;

  SignIn({this.switchShowSignIn});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String _currentEmail = '';
  String _currentPassword = '';

  final _formKey = GlobalKey<FormState>();

  // MARK: - Actions
  _signInButtonClicked() {
    if (_formKey.currentState.validate()) {
      print(_currentEmail);
      print(_currentPassword);
    }
  }

  _registerButtonClicked() {
    this.widget.switchShowSignIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text('Brew Crew Sign In'),
        centerTitle: true,
        backgroundColor: Colors.brown[400],
        elevation: 0,
      ),
      body: _body(),
    );
  }

  _body() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              _emailForm(),
              SizedBox(height: 20),
              _passwordForm(),
              SizedBox(height: 20),
              _signInButton(),
              SizedBox(height: 10),
              _signUpButton(),
            ],
          ),
        ),
      ),
    );
  }

  _emailForm() {
    return TextFormField(
      initialValue: '',
      onChanged: (value) {
        setState(() {
          _currentEmail = value;
        });
      },
      decoration: textFormDecoration.copyWith(hintText: 'Enter email'),
      validator: (val) {
        if (val.isEmpty) {
          return 'Please enter email';
        }

        bool emailValid = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(val);
        if (!emailValid) {
          return 'Email not valid. Please re-check';
        }

        return null;
      },
    );
  }

  _passwordForm() {
    return TextFormField(
      obscureText: true,
      onChanged: (value) {
        setState(() {
          _currentPassword = value;
        });
      },
      decoration: textFormDecoration.copyWith(hintText: 'Enter password'),
      validator: (val) => val.isEmpty ? 'Please enter password' : null,
    );
  }

  _signInButton() {
    return ButtonTheme(
      minWidth: 130,
      height: 45,
      child: RaisedButton(
        color: Colors.pink,
        textColor: Colors.white,
        splashColor: Colors.grey,
        child: Text('Sign In'),
        onPressed: _signInButtonClicked,
      ),
    );
  }

  _signUpButton() {
    return ButtonTheme(
      minWidth: 130,
      height: 45,
      child: RaisedButton(
        color: Colors.blue[400],
        textColor: Colors.white,
        splashColor: Colors.grey,
        child: Text('Register'),
        onPressed: _registerButtonClicked,
      ),
    );
  }
}
