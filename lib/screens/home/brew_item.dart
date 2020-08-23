import 'package:flutter/material.dart';
import 'package:brew_crew/models/brew.dart';

class BrewItem extends StatelessWidget {
  final Brew brew;

  BrewItem({this.brew});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/coffee_icon.png'),
            backgroundColor: Colors.brown[brew.strength],
            radius: 30,
          ),
          title: Text(
            brew.name,
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          subtitle: Text(
            '${brew.sugars} sugar(s)',
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
