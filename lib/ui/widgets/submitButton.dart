import 'package:flutter/material.dart';

Widget submitButton({String title = 'Submit', Function onPressed}) {
  return RaisedButton(
    child: Text(title),
    onPressed: onPressed,
  );
}
