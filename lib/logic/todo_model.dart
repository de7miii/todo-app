import 'package:flutter/material.dart';
import 'package:todo/logic/Todo.dart';

import 'Item.dart';
import 'item_model.dart';

class TodoModel with ChangeNotifier {
  TodoModel();

  List<Todo> _todos = [
  ];

  ItemModel _itemsModel;

  ItemModel get itemsModel => _itemsModel;

  List<Todo> get todos => _todos;

  List<Item> get items => itemsModel.items;

  set itemsModel(ItemModel newItems){
    assert(newItems != null);
    _itemsModel = newItems;
    notifyListeners();
  }

  int get todosCount => _todos.length;

  Todo getTodoById(int todoId) => _todos.where((element) => element.id == todoId).elementAt(0);

  List<Item> getTodoItems(int todoId) => itemsModel.getTodoItems(getTodoById(todoId));

  // TODO: Fetch Todos from the server.

  void createTodo(Todo todo){
    assert(todo != null);
    _todos.add(todo);
    notifyListeners();
  }

  void deleteTodo(int todoId){
    var todo = getTodoById(todoId);
    if (todo != null && _todos.contains(todo)) {
      _todos.remove(todo);
      notifyListeners();
    }
  }

  void addItem(Item item){
    assert(item != null);
    assert(itemsModel != null);
    itemsModel.add(item);
    notifyListeners();
  }

  void deleteItem(int id){
    assert(itemsModel != null);
    itemsModel.remove(id);
    notifyListeners();
  }
}