import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/screens/home/settings_brew.dart';
import 'package:brew_crew/services/brew_service.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth_service.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>>.value(
      value: BrewService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[40],
        appBar: AppBar(
          title: Text('Brew Crew'),
          centerTitle: false,
          backgroundColor: Colors.brown[400],
          elevation: 0,
          actions: [
            _settingButton(context),
            _logoutButton(),
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            )),
            child: BrewList()),
      ),
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

  _settingButton(BuildContext context) {
    return FlatButton.icon(
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                child: SettingsBrew(),
              );
            });
      },
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
}
