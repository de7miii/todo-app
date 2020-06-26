import 'package:flutter/material.dart';

import 'login.dart';
import 'signup.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-do-da',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/signup': (context) => SignUpPage(),
        '/login': (context) => LoginPage()
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade200,
        body: Center(
          child: Row(
            children: <Widget>[
              Expanded(
                child: RaisedButton(
                  child: Text('Login'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: RaisedButton(
                  child: Text('SignUp'),
                  onPressed: (){
                    Navigator.pushNamed(context, '/signup');
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
