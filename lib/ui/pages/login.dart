import 'package:flutter/material.dart';
import 'package:todo/ui/widgets/appBar.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

