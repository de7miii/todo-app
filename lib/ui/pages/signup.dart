import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/utils//AuthService.dart';
import 'package:todo/ui/widgets/appBar.dart';
import 'package:todo/ui/widgets/inputTextField.dart';
import 'package:todo/utils//validators.dart';
import 'package:todo/ui/widgets/submitButton.dart';

final _title = 'Sign Up';

class SignUpPage extends StatelessWidget {
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
      ),
    );
  }
}


