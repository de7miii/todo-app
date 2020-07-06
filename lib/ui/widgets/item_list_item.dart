import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/logic/Item.dart';
import 'package:todo/logic/todo_model.dart';

class ItemListItem extends StatefulWidget {
  @override
  _ItemListItemState createState() => _ItemListItemState();
  final List<Item> items;
  final int index;
  final TodoModel todoModel;
  Database db;
  ItemListItem(this.db, {this.items, this.index, this.todoModel});
}

class _ItemListItemState extends State<ItemListItem> {
  var isDone = false;
  @override
  Widget build(BuildContext context) {
    var item = widget.items[widget.index];
    return Column(
      children: <Widget>[
        Divider(
          thickness: 2.0,
          height: 0.0,
          color: Colors.black12,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              item.status = !item.status;
              isDone = !isDone;
            });
          },
          child: Dismissible(
            key: Key(item.content),
            background: Container(
              color: Colors.red.shade700,
            ),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              var currentItem = widget.items[widget.index];
              setState(() {
                widget.todoModel.deleteItem(currentItem.id, db: widget.db);
              });
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Deleted ${currentItem.content} from List"),
                behavior: SnackBarBehavior.floating,
                duration: Duration(milliseconds: 1000),
              ));
            },
            child: ListTile(
              leading: Checkbox(
                value: isDone,
                onChanged: (val) => {
                  setState(() {
                    item.status = val;
                    isDone = val;
                  })
                },
              ),
              title: isDone
                  ? Text(
                      item.content,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          decoration: TextDecoration.lineThrough,
                          fontSize: 16.0),
                    )
                  : Text(
                      item.content,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: 16.0),
                    ),
              trailing: GestureDetector(
                  onTap: () {
                    var currentItem = widget.items[widget.index];
                    setState(() {
                      widget.todoModel.deleteItem(currentItem.id, db: widget.db);
                    });
                  },
                  child: Icon(Icons.clear)),
            ),
          ),
        ),
        if (widget.index == widget.items.length - 1)
          Divider(
            thickness: 2.0,
            height: 0.0,
            color: Colors.black12,
          )
      ],
    );
  }
}
