import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/logic/Todo.dart';
import 'package:todo/logic/Item.dart';
import 'package:todo/logic/todo_model.dart';
import 'package:todo/ui/widgets/input_bottom_sheets.dart';
import 'package:todo/ui/widgets/item_list_item.dart';
import 'package:todo/ui/widgets/submit_button.dart';

Widget todoListItem(
    Key key,
    List<Todo> todos,
    int index,
    BuildContext context,
    TodoModel model,
    GlobalKey<FormState> formKey,
    String content,
    String createdAt,
    Database db) {
  var todo = todos[index];
  var todoItems = model.getTodoItems(todo.id);

  return Container(
    width: 400.0,
    child: Wrap(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 26.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(Icons.delete, color: Colors.teal.shade600, size: 26.0,),
                      onPressed: () {
                        model.deleteTodo(todo.id);
                      },
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                      child: Text(
                        todo.title,
                        style: Theme.of(context).textTheme.headline2.copyWith(color: Colors.teal.shade600),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(todo.createdAt,
                              style: Theme.of(context).textTheme.subtitle1)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Divider(
                        thickness: 2.0,
                        height: 5.0,
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Consumer<TodoModel>(
                          builder: (context, value, child) {
                            return ListView.builder(
                              itemBuilder: (context, index) {
                                return ItemListItem(db,
                                    items: todoItems,
                                    index: index,
                                    todoModel: model);
                              },
                              itemCount: value.getTodoItemsCount(todo.id),
                              shrinkWrap: true,
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: CustomButton(
                              onPressed: () {
                                createItemBottomSheet(context, todo.id, formKey,
                                    content, createdAt, db);
                              },
                              color: Colors.blueGrey.shade200,
                              child: Text(
                                'Add Item',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(color: Colors.teal.shade600),
                              ),
                              minWidth: 50.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
