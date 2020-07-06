import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/logic/Item.dart';
import 'package:todo/logic/Todo.dart';
import 'package:todo/logic/auth_model.dart';
import 'package:todo/logic/todo_model.dart';
import 'package:todo/ui/widgets/input_bottom_sheets.dart';
import 'package:todo/ui/widgets/submit_button.dart';
import 'package:todo/ui/widgets/todo_list_item.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  TodoModel todoModel;
  List<Todo> todoList;
  GlobalKey<State> _globalKey = GlobalKey();
  GlobalKey<FormState> _formKey = GlobalKey();
  String _content, _createdAt, _title, _createdBy = '';
  Database _db;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    todoModel = Provider.of<TodoModel>(context);
    assert(todoModel != null);
    todoList = todoModel.todos;
    _db = Provider.of<AuthModel>(context, listen: false).dbInstance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView.builder(
        itemBuilder: (_, index) {
          return todoListItem(_globalKey, todoList, index, context, todoModel,
              _formKey, _content, _createdAt, _db);
        },
        itemCount: todoModel.todosCount,
        scrollDirection: Axis.vertical,
      ),
      floatingActionButton: CustomButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 45.0,
        ),
        onPressed: () {
          createTodoBottomSheet(
              context, _formKey, _title, _createdBy, _createdAt, _db);
        },
        color: Colors.blueGrey,
        minWidth: 80.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
