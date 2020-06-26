import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade300,
        body: Padding(
          padding: const EdgeInsets.only(top: 120.0),
          child: SignUp(),
        ),
      ),
    );
  }
}

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  var _email, _name, _password, _passwordConfirmation = '';
  var _validationPassword = '';
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Email'
              ),
              validator: (value) => EmailValidator.validate(value)? null: 'Invalid email address',
              textInputAction: TextInputAction.next,
              onSaved: (email) => _email = email,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Name'
              ),
              validator: (value) {
                Pattern pattern = r'^[A-Z][a-zA-Z]{3,}(?: [A-Z][a-zA-Z]*){0,2}$';
                RegExp regex = RegExp(pattern);
                if (!regex.hasMatch(value))
                  return 'Invalid Name';
                else
                  return null;
              },
              textInputAction: TextInputAction.next,
              onSaved: (name) => _name = name,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Password'
              ),
              obscureText: true,
              validator: (value) {
                Pattern pattern = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$';
                RegExp regex = RegExp(pattern);
                if (!regex.hasMatch(value))
                  return 'Invalid Password, Password must contain one letter and one number.';
                else
                  return null;
              },
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (value) => _validationPassword = value,
              onSaved: (password) => _password = password,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Password Confirmation'
              ),
              obscureText: true,
              validator: (value) {
                if (value != _validationPassword)
                  return 'Confirmation must be same as password';
                else
                  return null;
              },
              textInputAction: TextInputAction.done,
              onSaved: (passwordConfirmation) => _passwordConfirmation = passwordConfirmation,
            ),
          ),
          RaisedButton(
            child: Text('Sign Up'),
            onPressed: () {
              if(_formKey.currentState.validate()){
                _formKey.currentState.save();
              }
            },
          )
        ],
      ),
    );
  }
}
