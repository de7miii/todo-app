import 'package:flutter/material.dart';
import 'package:todo/logic/Todo.dart';
import 'package:todo/logic/Item.dart';
import 'package:todo/ui/widgets/itemListItem.dart';

Widget todoListItem(Key key, List<Todo> todos, List<Item> items, int index, BuildContext context) {
  var todo = todos[index];
  return Container(
    width: 400.0,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(todo.title, style: Theme.of(context).textTheme.headline3,),
            SizedBox(height: 8.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(todo.createdBy),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(todo.createdAt),
                )
              ],
            ),
            Column(
              children: <Widget>[
                ListView.builder(itemBuilder: (context, index) {
                  return ItemListItem(items: items, index: index,);
                }, itemCount: items.length, shrinkWrap: true,),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}