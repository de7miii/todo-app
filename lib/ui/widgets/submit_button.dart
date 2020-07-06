import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {

  Function onPressed;
  ShapeBorder shape;
  Widget child;
  Color color;
  double minWidth;

  CustomButton({@required this.onPressed, this.shape = const StadiumBorder(), this.child, this.color, this.minWidth = 110.0});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: minWidth,
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
