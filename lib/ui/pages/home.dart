// Packages imports.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/logic/AuthModel.dart';
import 'package:todo/logic/ItemModel.dart';
import 'package:todo/logic/TodoModel.dart';
import 'package:todo/ui/widgets/EmptyTodoList.dart';
import 'package:todo/ui/widgets/TodoList.dart';

// Widgets imports.
import 'package:todo/ui/widgets/appBar.dart';

// Pages imports.
import 'login.dart';

final _title = 'To-Do-Da';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthModel()),
          Provider(create: (_) => ItemModel()),
          ChangeNotifierProxyProvider<ItemModel, TodoModel>(
            create: (_) => TodoModel(),
            update: (_, itemModel, todoModel) {
              todoModel.itemsModel = itemModel;
              return todoModel;
            },
          ),
        ],
        child: MaterialApp(title: _title, initialRoute: '/', routes: {
          '/': (context) => HomePage(),
          '/login': (context) => LoginPage()
        }));
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthModel>(
      builder: (context, value, child) {
        return value.getLoginStatus() ? child : LoginPage();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade50,
          image: DecorationImage(
            image: AssetImage('images/bg.png'),
          ),
        ),
        child: Scaffold(
          appBar: customAppBar(_title),
          backgroundColor: Colors.transparent,
          body: EmptyTodoList(),
        ),
      ),
    );
  }
}
