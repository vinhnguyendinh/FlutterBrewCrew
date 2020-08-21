import 'package:brew_crew/screens/authenticate/sign_in.dart';
import 'package:brew_crew/screens/authenticate/sign_up.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool _isShowSignIn = true;

  void switchShowSignIn() {
    setState(() {
      _isShowSignIn = !_isShowSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isShowSignIn
        ? SignIn(switchShowSignIn: switchShowSignIn)
        : SignUp(switchShowSignIn: switchShowSignIn);
  }
}
