// Packages imports.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Widgets imports.
import 'package:todo/ui/widgets/appBar.dart';

// Pages imports.
import 'login.dart';

// Helpers Imports
import 'package:todo/utils/AuthService.dart';

final _title = 'To-Do-Da';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: _title,
        routes: {
          '/home': (context) => HomePage(),
          '/login': (context) => LoginPage()
        },
        home: Consumer<AuthService>(
          builder: (context, value, child) {
            return value.getLoginStatus() ? HomePage() : LoginPage();
          },
        ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade50,
        image: DecorationImage(
          image: AssetImage('images/bg.png'),
        ),
      ),
      child: Scaffold(
        appBar: customAppBar(_title),
        backgroundColor: Colors.transparent,
        body: Center(
          child: RaisedButton(
            child: Text('Log Out'),
            onPressed: () => {
              Provider.of<AuthService>(context, listen: false).logOut(),
            },
          ),
        ),
      ),
    );
  }
}
