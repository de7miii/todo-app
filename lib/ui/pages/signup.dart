import 'package:flutter/material.dart';
import 'package:todo/ui/widgets/appBar.dart';
import 'package:todo/ui/widgets/inputTextField.dart';
import 'package:todo/helpers/validators.dart';
import 'package:todo/ui/widgets/submitButton.dart';

final _title = 'Sign Up';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(_title),
      backgroundColor: Colors.blueGrey.shade50,
      body: Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: SingleChildScrollView(child: SignUp()),
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
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: inputTextField(
                context: context,
                inputText: _email,
                autoValidate: true,
                autoFocus: true,
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
            padding: const EdgeInsets.all(16.0),
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
            padding: const EdgeInsets.all(16.0),
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
            padding: const EdgeInsets.all(16.0),
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
          submitButton(
            title: 'Sign Up',
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('Sign Up Done'),
                    backgroundColor: Colors.blueGrey.shade900));
              }
            },
          ),
        ],
      ),
    );
  }
}
