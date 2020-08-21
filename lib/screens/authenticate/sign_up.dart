import 'package:flutter/material.dart';
import 'package:brew_crew/utils/constant.dart';
import 'package:flutter/rendering.dart';

class SignUp extends StatefulWidget {
  Function switchShowSignIn;

  SignUp({this.switchShowSignIn});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _currentEmail = '';
  String _currentPassword = '';
  String _currentConfirmPassword = '';

  final _formKey = GlobalKey<FormState>();

  // MARK: - Actions
  _signInButtonClicked() {
    this.widget.switchShowSignIn();
  }

  _registerButtonClicked() {
    if (_formKey.currentState.validate()) {
      print(_currentEmail);
      print(_currentPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Brew Crew Sign Up'),
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
              _confirmPasswordForm(),
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
      validator: (val) {
        if (val.isEmpty) {
          return 'Please enter password';
        }

        if (_currentPassword != _currentConfirmPassword) {
          return 'Password and confirmed password not matched.';
        }

        return null;
      },
    );
  }

  _confirmPasswordForm() {
    return TextFormField(
      obscureText: true,
      onChanged: (value) {
        setState(() {
          _currentConfirmPassword = value;
        });
      },
      decoration:
          textFormDecoration.copyWith(hintText: 'Enter confirmed password'),
      validator: (val) {
        if (val.isEmpty) {
          return 'Please enter confirmed password';
        }

        if (_currentPassword != _currentConfirmPassword) {
          return 'Password and confirmed password not matched.';
        }

        return null;
      },
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
        child: Text('Register'),
        onPressed: _registerButtonClicked,
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
        child: Text('Back to sign in'),
        onPressed: _signInButtonClicked,
      ),
    );
  }
}
