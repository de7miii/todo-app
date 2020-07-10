import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/logic/auth_model.dart';
import 'package:todo/logic/todo_model.dart';
import 'package:todo/ui/widgets/submit_button.dart';
import 'package:todo/ui/widgets/todo_list.dart';
import 'input_bottom_sheets.dart';
import 'package:todo/logic/Todo.dart';
import 'package:todo/ui/widgets/input_text_field.dart';

class EmptyTodoList extends StatefulWidget {
  // TODO: implement a stateful widget to handle the case when the todo list api is empty.
  @override
  _EmptyTodoListState createState() => _EmptyTodoListState();
}

class _EmptyTodoListState extends State<EmptyTodoList> {

  final _formKey = GlobalKey<FormState>();
  var _title, _createdBy, _createdAt = '';


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<TodoModel>(context, listen: false).fetchTodosFromDB();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoModel>(
      builder: (context, value, child) {
        return value.todosCount == 0 ? child : TodoList();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Oh no! you have no todos',
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(height: 24.0),
              CustomButton(
                shape: StadiumBorder(),
                color: Colors.blueGrey.shade200,
                child: Text('New Todo', style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.teal.shade600),),
                onPressed: () {
                  createTodoBottomSheet(context, _formKey, _title, _createdBy, _createdAt);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
