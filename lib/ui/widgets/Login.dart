import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/utils/AuthService.dart';
import 'inputTextField.dart';
import 'submitButton.dart';
import 'package:todo/utils/validators.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  var _email, _password = '';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 16.0, left: 16.0, top: 16.0),
                child: inputTextField(
                    context: context,
                    inputText: _email,
                    autoFocus: false,
                    autoValidate: true,
                    labelText: 'Email',
                    hintText: 'Please enter a valid email',
                    textInputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.none,
                    obscureText: false,
                    validator: (value) => validateEmail(value),
                    onSubmitted: (value) {
                      FocusScope.of(context).nextFocus();
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0, left: 16.0, top: 16.0),
                child: inputTextField(
                    context: context,
                    inputText: _password,
                    autoFocus: false,
                    autoValidate: false,
                    labelText: 'Password',
                    hintText: 'Please enter your password',
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    textCapitalization: TextCapitalization.none,
                    obscureText: true,
                    validator: (value) => value.isEmpty
                        ? 'Invalid Password. Password cannot be empty'
                        : null,
                    onSubmitted: (value) {
                      FocusScope.of(context).unfocus();
                    }),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 64.0, right: 64.0, top: 16.0),
                      child: FlatButton(
                        child: Text('Need an account?'),
                        onPressed: () {
                          Provider.of<AuthService>(context, listen: false).setSignupState(true);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0, top: 16.0),
                    child: submitButton(
                        title: 'Sign In',
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('Sign In Submit Pressed'),
                                backgroundColor: Colors.blueGrey.shade900));
                            Provider.of<AuthService>(context, listen: false).logIn();
                          }
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}