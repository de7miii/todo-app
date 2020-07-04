import 'package:todo/logic/Item.dart';
import 'dart:core';

import 'package:todo/logic/Todo.dart';

class ItemModel {
  ItemModel();

  List<Item> _items = [
    Item(
        id: 1,
        todoId: 1,
        content: 'Scarface',
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().add(Duration(days: 50)).toIso8601String(),
        status: false),
    Item(
        id: 2,
        todoId: 1,
        content: 'Goodfellas',
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().add(Duration(days: 20)).toIso8601String(),
        status: false),
    Item(
        id: 3,
        todoId: 1,
        content: 'The Godfather I',
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().add(Duration(days: 5)).toIso8601String(),
        status: false),
    Item(
        id: 4,
        todoId: 2,
        content: 'The Irishman',
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().add(Duration(days: 7)).toIso8601String(),
        status: false),
    Item(
        id: 5,
        todoId: 2,
        content: 'Gangs of New York',
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().add(Duration(days: 35)).toIso8601String(),
        status: false),
    Item(
        id: 6,
        todoId: 2,
        content: 'Wolf of Wall Street',
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().add(Duration(days: 1)).toIso8601String(),
        status: false),
    Item(
        id: 7,
        todoId: 2,
        content: 'Dunkirk',
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().add(Duration(days: 1)).toIso8601String(),
        status: false),
    Item(
        id: 8,
        todoId: 2,
        content: 'Tenet',
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().add(Duration(days: 1)).toIso8601String(),
        status: false),
  ];

  List<Item> get items => _items;

  List<Item> getTodoItems(Todo todo) =>
      _items.where((element) => element.todoId == todo.id).toList();

  Item getItemById(int id) => _items.where((element) => element.id == id).elementAt(0);

  // TODO: Fetch Items from the server.

  add(Item item) {
    assert(item != null);
    _items.add(item);
  }

  addItems(List<Item> items){
    _items.addAll(items);
  }

  remove(int id){
    var item = getItemById(id);
    if(item != null && _items.contains(item)) {
      _items.remove(item);
    }
  }
}
