import 'package:flutter/material.dart';

Widget customAppBar({String title, Color bgColor = Colors.blueGrey, List<Widget> actions}){
  return AppBar(
    title: Text(title),
    backgroundColor: bgColor,
    actions: actions,
  );
}
