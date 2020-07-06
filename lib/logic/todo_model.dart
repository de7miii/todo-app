import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/logic/Todo.dart';

import 'Item.dart';
import 'item_model.dart';

class TodoModel with ChangeNotifier {
  TodoModel();

  List<Todo> _todos = [];

  ItemModel _itemsModel;

  ItemModel get itemsModel => _itemsModel;

  List<Todo> get todos => _todos;

  set todos(List<Todo> todos) {
    assert(todos != null);
    _todos = todos;
    notifyListeners();
  }

  List<Item> get items => itemsModel.items;

  set itemsModel(ItemModel newItems) {
    assert(newItems != null);
    _itemsModel = newItems;
    notifyListeners();
  }

  int get todosCount => todos.length;


  Todo getTodoById(int todoId) =>
      todos.where((element) => element.id == todoId).elementAt(0);

  List<Item> getTodoItems(int todoId) {
    itemsModel.fetchItemsFromDb();
    return itemsModel.getTodoItems(getTodoById(todoId));
  }

  Future fetchTodosFromDB({Database db}) async {
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), 'to_do_da.db'));
    }
    List<Map<String, dynamic>> dbTodos = await db.query('todos');

    todos = List.generate(dbTodos.length, (index) {
      return Todo(
          id: dbTodos[index]['id'],
          title: dbTodos[index]['title'],
          createdAt: dbTodos[index]['created_at'],
          createdBy: dbTodos[index]['created_by'],
          updatedAt: dbTodos[index]['updated_at']);
    });
    return Future.value(todos);
  }

  void createTodo(Todo todo, {Database db}) async {
    assert(todo != null);
    _todos.add(todo);
    notifyListeners();
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), 'to_do_da.db'));
    }
    await db.insert('todos', todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    notifyListeners();
  }

  void deleteTodo(int todoId, {Database db}) async {
    var todo = getTodoById(todoId);
    if(db == null) {
      db = await openDatabase(join(await getDatabasesPath(), 'to_do_da.db'));
    }
    if (todo != null && _todos.contains(todo)) {
      _todos.remove(todo);
      await db.delete('todos', where: 'id = ?', whereArgs: [todoId]);
      notifyListeners();
    }
  }

  void addItem(Item item, {Database db}) {
    assert(item != null);
    assert(itemsModel != null);
    itemsModel.add(item, db);
    notifyListeners();
  }

  void deleteItem(int id, {Database db}) {
    assert(itemsModel != null);
    itemsModel.remove(id, db);
    notifyListeners();
  }
}
