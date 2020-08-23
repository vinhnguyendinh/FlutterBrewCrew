import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/auth_service.dart';
import 'package:brew_crew/utils/constant.dart';
import 'package:brew_crew/utils/loading/loading.dart';
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

  final _authService = AuthService();

  bool _isLoading = false;
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Loading()
        : Scaffold(
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

  // Body widget
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
              SizedBox(height: 20),
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red, fontSize: 15),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }

  // Email text form field widget
  _emailForm() {
    return TextFormField(
      initialValue: _currentEmail,
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

  // Password text form field widget
  _passwordForm() {
    return TextFormField(
      initialValue: _currentPassword,
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

  // Sign in button widget
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

  // Sign up button widget
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

  // MARK: - Actions
  _signInButtonClicked() async {
    if (_formKey.currentState.validate()) {
      // Show loading
      this.setState(() {
        _isLoading = true;
      });

      // Sign in with email and password
      UserModel user = await _authService.handleSignInEmail(
          email: _currentEmail, password: _currentPassword);

      // Hide loading
      if (user != null) {
        this.setState(() {
          _errorMessage = '';
          _isLoading = false;
        });
      } else {
        this.setState(() {
          _errorMessage =
              'Authentication failed. Please check email and password.';
          _isLoading = false;
        });
      }
    }
  }

  _registerButtonClicked() {
    this.widget.switchShowSignIn();
  }
}
