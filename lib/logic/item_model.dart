import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/logic/Item.dart';
import 'dart:core';

import 'package:todo/logic/Todo.dart';

class ItemModel {
  ItemModel();

  List<Item> _items = [];

  List<Item> get items => _items;

  int get itemsCount => _items.length;

  int _id = 1;

  int get id => _id;

  set id(int newId) {
    assert(newId != null);
    _id = newId;
  }

  set items(List<Item> newItems) {
    assert(newItems != null);
    _items = newItems;
  }

  List<Item> getTodoItems(Todo todo) {
    fetchItemsFromDb();
    return items.where((element) => element.todoId == todo.id).toList();
  }

  void deleteTodoItems(Todo todo){
    fetchItemsFromDb();
    items.removeWhere((element) => element.todoId == todo.id);
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

  add(Item item, Database db) {
    assert(item != null);
    item.id = id;
    _items.add(item);
    insert(item.toMap(), db);
    id = id + 1;
  }

  remove(int id, Database db) {
    var item = getItemById(id);
    if (item != null && _items.contains(item)) {
      _items.remove(item);
      delete(item.id, db);
    }
  }

  insert(Map<String, dynamic> item, Database db) async {
    if (db == null) {
      try {
        db = await openDatabase(join(await getDatabasesPath(), 'to_do_da.db'),
            singleInstance: true);
      } catch (e) {
        print(e);
      }
    }
    return await db.insert('items', item);
  }

  delete(int itemId, Database db) async {
    if (db == null) {
      try {
        db = await openDatabase(join(await getDatabasesPath(), 'to_do_da.db'),
            singleInstance: true);
      } catch (e) {
        print(e);
      }
    }
    return await db.delete('items', where: 'id = ?', whereArgs: [itemId]);
  }
}
