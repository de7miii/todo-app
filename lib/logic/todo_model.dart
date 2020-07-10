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

  int _id = 1;

  int get id => _id;

  set id(int newId){
    assert(newId != null);
    _id = newId;
  }

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

  int get itemsCount => itemsModel.itemsCount;

  Todo getTodoById(int todoId) {
    return todos.where((element) => element.id == todoId).elementAt(0);
  }

  List<Item> getTodoItems(int todoId) {
    return itemsModel.getTodoItems(getTodoById(todoId));
  }

  int getTodoItemsCount(int todoId){
    return getTodoItems(todoId).length;
  }

  Future fetchTodosFromDB({Database db}) async {
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), 'to_do_da.db'),
          singleInstance: true);
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

  Future fetchItemsFromDb({Database db}) async {
    await itemsModel.fetchItemsFromDb();
    notifyListeners();
    return Future.value(itemsModel.items);
  }

  void createTodo(Todo todo, {Database db}) async {
    assert(todo != null);
    todo.id = id;
    _todos.add(todo);
    id++;
    notifyListeners();
    if (db == null) {
      try {
        db = await openDatabase(join(await getDatabasesPath(), 'to_do_da.db'),
            singleInstance: true);
        await db.insert('todos', todo.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      } catch (e) {
        print(e);
      }
    }
    notifyListeners();
  }

  void deleteTodo(int todoId, {Database db}) async {
    var todo = getTodoById(todoId);
    if (todo != null && todos.contains(todo)) {
      itemsModel.deleteTodoItems(todo);
      _todos.remove(todo);
      notifyListeners();
      if (db == null) {
        try {
          db = await openDatabase(join(await getDatabasesPath(), 'to_do_da.db'),
              singleInstance: true);
          await db.delete('todos', where: 'id = ?', whereArgs: [todoId]);
        } catch (e) {
          print(e);
        }
      }
      notifyListeners();
    }
  }

  void addItem(Item item, {Database db}) async {
    assert(item != null);
    assert(itemsModel != null);
//    if (db == null) {
//      try{
//        db = await openDatabase(join(await getDatabasesPath(), 'to_do_da.db'),
//            singleInstance: true);
//        print('------');
//      }catch(e){
//        print(e);
//      }
//    }
    itemsModel.add(item, db);
    notifyListeners();
  }

  void deleteItem(int id, {Database db}) async {
    assert(itemsModel != null);
//    if (db == null) {
//      db = await openDatabase(join(await getDatabasesPath(), 'to_do_da.db'),
//          singleInstance: true);
//    }
    itemsModel.remove(id, db);
    notifyListeners();
  }
}
