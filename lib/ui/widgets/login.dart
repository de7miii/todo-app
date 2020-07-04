import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/logic/auth_model.dart';
import 'input_text_field.dart';
import 'submit_button.dart';
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
                child: InputTextField(
                    context: context,
                    onSaved: (value) => _email = value,
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
                child: InputTextField(
                    context: context,
                    onSaved: (value) => _password = value,
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
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 32.0, right: 96.0),
                        child: FlatButton(
                          child: Text('Need an account?'),
                          onPressed: () {
                            Provider.of<AuthModel>(context, listen: false).setSignupState(true);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 24.0),
                      child: CustomButton(
                          child: Text('Sign In'),
                          color: Colors.blueGrey.shade200,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              print(_email);
                              print(_password);
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('Sign In Submit Pressed'),
                                  backgroundColor: Colors.blueGrey.shade900));
                              Provider.of<AuthModel>(context, listen: false).logIn();
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}