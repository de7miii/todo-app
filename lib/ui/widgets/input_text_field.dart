import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputTextField extends StatelessWidget {

  Function(String) validator;
  Function(String) onSubmitted;
  bool autoValidate;
  bool autoFocus;
  String hintText;
  String labelText;
  TextInputType textInputType;
  TextInputAction textInputAction;
  TextCapitalization textCapitalization;
  bool obscureText;
  Function(String) onChanged;
  Function(String) onSaved;


  InputTextField({BuildContext context,
    this.onSaved,
    this.validator,
    this.onSubmitted,
    this.autoValidate = false,
    this.autoFocus = false,
    this.hintText,
    this.labelText,
    this.textInputAction = TextInputAction.next,
    this.textInputType,
    this.textCapitalization = TextCapitalization.none,
    this.obscureText = false,
    this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidate: autoValidate,
      autofocus: autoFocus,
      decoration: InputDecoration(hintText: hintText, labelText: labelText),
      validator: validator,
      textInputAction: textInputAction,
      onSaved: onSaved,
      onFieldSubmitted: onSubmitted,
      obscureText: obscureText,
      onChanged: onChanged,
      textCapitalization: textCapitalization,
      keyboardType: textInputType,
    );
  }
}

Widget inputTextField(
    {BuildContext context,
    String inputText,
    Function(String) validator,
    Function(String) onSubmitted,
    bool autoValidate = false,
    bool autoFocus = false,
    String hintText,
    String labelText,
    TextInputAction textInputAction = TextInputAction.next,
    TextInputType textInputType,
    TextCapitalization textCapitalization,
    bool obscureText = false,
    Function(String) onChanged}) {
  return TextFormField(
    autovalidate: autoValidate,
    autofocus: autoFocus,
    decoration: InputDecoration(hintText: hintText, labelText: labelText),
    validator: validator,
    textInputAction: textInputAction,
    onSaved: (value) => inputText = value,
    onFieldSubmitted: onSubmitted,
    obscureText: obscureText,
    onChanged: onChanged,
    textCapitalization: textCapitalization,
    keyboardType: textInputType,
  );
}
