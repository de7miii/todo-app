import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/utils/AuthService.dart';
import 'inputTextField.dart';
import 'submitButton.dart';
import 'package:todo/utils/validators.dart';


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
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 16.0, left: 16.0, top: 16.0),
                child: inputTextField(
                    context: context,
                    inputText: _email,
                    autoValidate: true,
                    autoFocus: false,
                    hintText: 'Enter a valid email',
                    labelText: 'Email',
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.none,
                    textInputType: TextInputType.emailAddress,
                    validator: (value) => validateEmail(value),
                    onSubmitted: (value) {
                      FocusScope.of(context).nextFocus();
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0, left: 16.0, top: 16.0),
                child: inputTextField(
                  context: context,
                  inputText: _name,
                  hintText: 'Enter your name',
                  labelText: 'Name',
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  textInputType: TextInputType.text,
                  validator: (value) => validateName(value),
                  onSubmitted: (value) {
                    FocusScope.of(context).nextFocus();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0, left: 16.0, top: 16.0),
                child: inputTextField(
                  context: context,
                  inputText: _password,
                  hintText: 'Please enter a unique password',
                  labelText: 'Password',
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.none,
                  textInputType: TextInputType.text,
                  validator: (value) => validatePassword(value),
                  onChanged: (value) => {
                    setState(() {
                      _validationPassword = value;
                    })
                  },
                  onSubmitted: (value) {
                    FocusScope.of(context).nextFocus();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0, left: 16.0, top: 16.0),
                child: inputTextField(
                  context: context,
                  inputText: _passwordConfirmation,
                  autoValidate: true,
                  hintText: 'Enter your passwrod again please',
                  labelText: 'Password Confirmation',
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.none,
                  textInputType: TextInputType.text,
                  validator: (value) =>
                      validateConfirmationPassword(value, _validationPassword),
                  onSubmitted: (value) {
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 36.0, right: 64.0, top: 16.0),
                      child: FlatButton(
                        child: Text('Alreade have an account?'),
                        onPressed: () {
                          Provider.of<AuthService>(context, listen: false).setSignupState(false);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0, top: 16.0),
                    child: submitButton(
                      title: 'Sign Up',
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text('Sign Up Done'),
                              backgroundColor: Colors.blueGrey.shade900));
                          Provider.of<AuthService>(context, listen: false).signUp();
                        }
                      },
                    ),
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