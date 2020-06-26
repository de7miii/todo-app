import 'package:flutter/material.dart';
import 'package:todo/ui/widgets/appBar.dart';

import 'login.dart';
import 'signup.dart';

final _title = 'To-Do-Da';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
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
    return Scaffold(
      appBar: customAppBar(_title),
      backgroundColor: Colors.blueGrey.shade50,
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
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
