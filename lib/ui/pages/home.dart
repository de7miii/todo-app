// Packages imports.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/logic/auth_model.dart';
import 'package:todo/logic/item_model.dart';
import 'package:todo/logic/todo_model.dart';
import 'package:todo/ui/widgets/empty_todo_list.dart';
import 'package:todo/ui/widgets/app_bar.dart';
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
          appBar: customAppBar(
            title: _title,
            actions: <Widget>[
              FlatButton(
                child: Text('Log out'),
                onPressed: () {
                  Provider.of<AuthModel>(context, listen: false).logOut();
                },
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          body: EmptyTodoList(),
        ),
      ),
    );
  }
}
