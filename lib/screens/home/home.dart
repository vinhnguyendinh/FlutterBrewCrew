import 'package:brew_crew/main.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth_service.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brew Crew'),
        centerTitle: true,
        actions: [
          RaisedButton(
              child: Text('Logout'),
              color: null,
              onPressed: () async {
                await _authService.signOut();
                print('Sign out success');
              })
        ],
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
