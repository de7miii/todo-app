import 'package:flutter/material.dart';
import 'package:todo/logic/Item.dart';

class ItemListItem extends StatefulWidget {
  @override
  _ItemListItemState createState() => _ItemListItemState();
  final List<Item> items;
  final int index;
  ItemListItem({this.items, this.index});
}

class _ItemListItemState extends State<ItemListItem> {
  @override
  Widget build(BuildContext context) {
    var item = widget.items[widget.index];
    return ListTile(
      leading: Checkbox(
        value: item.status,
        onChanged: (val) => {
          setState(() => {item.status = val})
        },
      ),
      title: Text(item.content, style: Theme.of(context).textTheme.bodyText1),
    );;
  }
}


Widget itemListItem(List<Item> items, int index, BuildContext context) {
  var item = items[index];
  return ListTile(
    leading: Checkbox(
      value: item.status,
      onChanged: (val) => {},
    ),
    title: Text(item.content, style: Theme.of(context).textTheme.bodyText1),
  );
}
