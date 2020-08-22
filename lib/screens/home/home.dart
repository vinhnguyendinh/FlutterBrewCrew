import 'package:brew_crew/main.dart';
import 'package:brew_crew/services/brew_service.dart';
import 'package:brew_crew/utils/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth_service.dart';
import 'package:brew_crew/models/brew.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Brew>>(
      stream: BrewService().brews,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        }

        snapshot.data.forEach((brew) {
          print(brew.name);
        });

        return Scaffold(
          appBar: AppBar(
            title: Text('Brew Crew'),
            centerTitle: false,
            backgroundColor: Colors.brown[400],
            elevation: 0,
            actions: [
              _settingButton(),
              _logoutButton(),
            ],
          ),
          body: _body(),
        );
      },
    );
  }

  _logoutButton() {
    return FlatButton.icon(
      onPressed: () async {
        await _authService.signOut();
        print('Sign out success');
      },
      icon: Icon(
        Icons.person,
        color: Colors.white,
      ),
      label: Text(
        'Logout',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  _settingButton() {
    return FlatButton.icon(
      onPressed: () async {},
      icon: Icon(
        Icons.settings,
        color: Colors.white,
      ),
      label: Text(
        'Settings',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  _body() {
    return Column(
      children: [],
    );
  }
}
