import 'package:flutter/material.dart';
import 'package:todo/ui/widgets/appBar.dart';
import 'package:todo/ui/widgets/inputTextField.dart';
import 'package:todo/helpers/validators.dart';
import 'package:todo/ui/widgets/submitButton.dart';

final _title = 'Login';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(_title),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(child: Login()),
      ),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  var _email, _password = '';
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: inputTextField(
              context: context,
              inputText: _email,
              autoFocus: true,
              autoValidate: true,
              labelText: 'Email',
              hintText: 'Please enter a valid email',
              textInputType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.none,
              obscureText: false,
              validator: (value) => validateEmail(value),
              onSubmitted: (value) {FocusScope.of(context).nextFocus();}
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
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
              validator: (value) => value.isEmpty? 'Invalid Password. Password cannot be empty' : null,
              onSubmitted: (value) {FocusScope.of(context).unfocus();}
            ),
          ),
          submitButton(
            title: 'Sign In',
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('Sign In Submit Pressed'),
                    backgroundColor: Colors.blueGrey.shade900));
              }
            }
          ),
        ],
      ),
    );
  }
}
