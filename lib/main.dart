import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/utils/AuthService.dart';

import 'ui/pages/home.dart';

void main() => runApp(ChangeNotifierProvider(
      create: (_) => AuthService(),
      child: Consumer<AuthService>(
          builder: (context, value, child) {
            return MyApp();
          }
      ),
    ));
