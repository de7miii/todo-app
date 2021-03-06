import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/logic/auth_model.dart';
import 'input_text_field.dart';
import 'submit_button.dart';
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
                child: InputTextField(
                    context: context,
                    onSaved: (value) => _email = value,
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
                child: InputTextField(
                  context: context,
                  onSaved: (value) => _name = value,
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
                child: InputTextField(
                  context: context,
                  onSaved: (value) => _password = value,
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
                child: InputTextField(
                  context: context,
                  onSaved: (value) => _passwordConfirmation = value,
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
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 32.0, right: 52.0),
                        child: FlatButton(
                          child: Text('Already have an account?'),
                          onPressed: () {
                            Provider.of<AuthModel>(context, listen: false).setSignupState(false);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 24.0),
                      child: CustomButton(
                        color: Colors.blueGrey.shade200,
                        child: Text('Sign Up'),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('Sign Up Done'),
                                backgroundColor: Colors.blueGrey.shade900));
                            Provider.of<AuthModel>(context, listen: false).signUp();
                          }
                        },
                      ),
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