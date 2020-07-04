import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {

  Function onPressed;
  ShapeBorder shape;
  Widget child;
  Color color;

  CustomButton({@required this.onPressed, this.shape = const StadiumBorder(), this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 110.0,
      height: 45.0,
      child: RaisedButton(
        onPressed: onPressed,
        shape: shape,
        child: child,
        color: color,
      ),
    );
  }
}


Widget submitButton({String title = 'Submit', Function onPressed}) {
  return RaisedButton(
    child: Text(title),
    onPressed: onPressed,
  );
}
