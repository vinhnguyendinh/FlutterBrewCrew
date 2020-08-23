import 'package:brew_crew/models/brew.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/screens/home/brew_item.dart';
import 'package:provider/provider.dart';

class BrewList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final brewList = Provider.of<List<Brew>>(context) ?? [];

    return ListView.builder(
      itemCount: brewList.length,
      itemBuilder: (context, index) {
        return BrewItem(brew: brewList[index]);
      },
    );
  }
}
