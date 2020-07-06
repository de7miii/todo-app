import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/logic/Item.dart';
import 'dart:core';

import 'package:todo/logic/Todo.dart';

class ItemModel {
  ItemModel();

  List<Item> _items = [];

  List<Item> get items => _items;

  set items(List<Item> newItems) {
    assert(newItems != null);
    _items = newItems;
  }

  List<Item> getTodoItems(Todo todo) {
    fetchItemsFromDb();
    return items.where((element) => element.todoId == todo.id).toList();
  }

  Item getItemById(int id) {
    fetchItemsFromDb();
    return items.where((element) => element.id == id).elementAt(0);
  }

  Future<List<Item>> fetchItemsFromDb({Database db}) async {
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), 'to_do_da.db'));
    }
    List<Map<String, dynamic>> dbItems = await db.query('items');

    items = List.generate(dbItems.length, (index) {
      return Item(
          id: dbItems[index]['id'],
          todoId: dbItems[index]['todo_id'],
          content: dbItems[index]['content'],
          createdAt: dbItems[index]['created_at'],
          status: dbItems[index]['status'] == 0 ? false : true,
          updatedAt: dbItems[index]['updated_at']);
    });
    return Future.value(items);
  }

  add(Item item, Database db) async {
    assert(item != null);
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), 'to_do_da.db'), readOnly: false);
    }
    await db.insert('items', item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    _items.add(item);
  }

  remove(int id, Database db) async {
    var item = getItemById(id);
    if (item != null && _items.contains(item)) {
      if (db == null) {
        db = await openDatabase(join(await getDatabasesPath(), 'to_do_da.db'), readOnly: false);
      }
      _items.remove(item);
      await db.delete('items', where: 'id = ?', whereArgs: [id]);
    }
  }
}
