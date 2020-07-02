import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/logic/Item.dart';
import 'package:todo/logic/Todo.dart';
import 'package:todo/logic/TodoModel.dart';
import 'package:todo/ui/widgets/todoListItem.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  TodoModel todoModel;
  List<Todo> todoList;
  List<Item> itemList;
  GlobalKey<State> _globalKey = GlobalKey();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    todoModel = Provider.of<TodoModel>(context);
    assert(todoModel != null);
    todoList = todoModel.todos;
    itemList = todoModel.items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView.builder(
          itemBuilder: (_, index) {
            return todoListItem(_globalKey, todoList, itemList, index, context);
          },
          itemCount: todoList.length,
          scrollDirection: Axis.horizontal,
        ));
  }
}
