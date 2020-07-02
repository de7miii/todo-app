import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/logic/AuthModel.dart';
import 'package:todo/ui/widgets/SignUp.dart';
import 'package:todo/ui/widgets/Login.dart';
import 'package:todo/ui/widgets/appBar.dart';

final _title = 'Login';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/bg.png'),
          ),
          color: Colors.blueGrey.shade50),
      child: Scaffold(
          appBar: customAppBar(_title),
          backgroundColor: Colors.transparent,
          body: Consumer<AuthModel>(
            builder: (context, value, child) {
              return value.signup? SignUp() : Login();
            },
          ),
      ),
    );
  }
}
