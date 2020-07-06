import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/logic/auth_model.dart';
import 'package:todo/ui/widgets/signup.dart';
import 'package:todo/ui/widgets/login.dart';
import 'package:todo/ui/widgets/app_bar.dart';

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
          appBar: customAppBar(title: _title),
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
