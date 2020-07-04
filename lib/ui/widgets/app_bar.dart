import 'package:flutter/material.dart';

Widget customAppBar(String title, {Color bgColor = Colors.blueGrey}){
  return AppBar(
    title: Text(title),
    backgroundColor: bgColor,
  );
}
