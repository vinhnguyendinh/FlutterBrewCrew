import 'package:flutter/material.dart';

const textFormDecoration = InputDecoration(
  focusColor: Colors.white,
  fillColor: Colors.white,
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(color: Colors.pink),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(color: Colors.white),
  ),
  filled: true,
  border: InputBorder.none,
  contentPadding: EdgeInsets.all(8),
);
