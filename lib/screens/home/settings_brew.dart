import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/utils/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/utils/constant.dart';
import 'package:brew_crew/models/user.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/services/brew_service.dart';

class SettingsBrew extends StatefulWidget {
  @override
  _SettingsBrewState createState() => _SettingsBrewState();
}

class _SettingsBrewState extends State<SettingsBrew> {
  String _currentName;
  String _currentSugars;
  int _currentStrength;

  final List<String> _sugars = ['0', '1', '2', '3', '4', '5'];

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Get user from stream
    final user = Provider.of<UserModel>(context);

    return StreamBuilder<Brew>(
        stream: BrewService(uid: user.uid).brewData,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (!snapshot.hasData) {
            return Loading();
          }

          // Get brew model
          final brew = snapshot.data;

          return Form(
            key: _formKey,
            child: Column(children: [
              Text(
                'Update your brew settings',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              _nameTextForm(brew),
              SizedBox(height: 20),
              _dropdownButtonFormField(brew),
              SizedBox(height: 20),
              _slider(brew),
              SizedBox(height: 20),
              _updateButton(user: user, brew: brew),
            ]),
          );
        });
  }

  _nameTextForm(Brew brew) {
    return TextFormField(
      initialValue: _currentName ?? brew.name,
      onChanged: (value) {
        setState(() {
          _currentName = value;
        });
      },
      decoration: textFormDecoration.copyWith(hintText: 'Enter name'),
      validator: (val) => val.isEmpty ? 'Please enter name' : null,
    );
  }

  _dropdownButtonFormField(Brew brew) {
    return DropdownButtonFormField(
      value: _currentSugars ?? brew.sugars,
      items: _sugars.map((sugar) {
        return DropdownMenuItem(
            value: sugar,
            child: Text(
              '$sugar sugar(s)',
              style: TextStyle(fontSize: 15, color: Colors.black),
            ));
      }).toList(),
      onChanged: (val) {
        setState(() {
          _currentSugars = val;
        });
      },
    );
  }

  _slider(Brew brew) {
    return Slider(
        value: (_currentStrength ?? brew.strength).toDouble(),
        min: 100,
        max: 900,
        activeColor: Colors.brown[_currentStrength ?? brew.strength],
        inactiveColor: Colors.brown[_currentStrength ?? brew.strength],
        divisions: 8,
        onChanged: (val) {
          setState(() {
            _currentStrength = val.toInt();
          });
        });
  }

  _updateButton({UserModel user, Brew brew}) {
    return RaisedButton(
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          // Update brew
          await BrewService(uid: user.uid).updateBrew(
              name: _currentName ?? brew.name,
              sugars: _currentSugars ?? brew.sugars,
              strength: _currentStrength ?? brew.strength);

          Navigator.pop(context);
        }
      },
      child: Text(
        'Update',
        style: TextStyle(color: Colors.white),
      ),
      color: Colors.pink[400],
    );
  }
}
