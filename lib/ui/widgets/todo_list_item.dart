import 'package:flutter/material.dart';
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
    String createdAt) {
  var todo = todos[index];
  var todoItems = model.getTodoItems(todo.id);
  return Container(
    width: 400.0,
    child: Wrap(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                child: Text(
                  todo.title,
                  style: Theme.of(context).textTheme.headline2,
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
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return ItemListItem(
                          items: todoItems, index: index, todoModel: model);
                    },
                    itemCount: todoItems.length,
                    shrinkWrap: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.bottomRight,
          child: CustomButton(
            onPressed: () {
              createItemBottomSheet(context, todo.id, formKey, content, createdAt);
            },
            color: Colors.blueGrey.shade200,
            child: Icon(Icons.add),
          ),
        ),
      )
    ]),
  );
}
