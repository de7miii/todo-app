import 'package:flutter/material.dart';

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
