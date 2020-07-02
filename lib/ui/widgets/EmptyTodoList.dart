import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/logic/TodoModel.dart';
import 'package:todo/ui/widgets/TodoList.dart';
import 'package:todo/logic/Todo.dart';
import 'package:todo/ui/widgets/inputTextField.dart';

class EmptyTodoList extends StatefulWidget {
  // TODO: implement a stateful widget to handle the case when the todo list api is empty.
  @override
  _EmptyTodoListState createState() => _EmptyTodoListState();
}

class _EmptyTodoListState extends State<EmptyTodoList> {
  final _formKey = GlobalKey<FormState>();
  var _title, _createdBy, _createdAt = '';
  @override
  Widget build(BuildContext context) {
    return Consumer<TodoModel>(
      builder: (context, value, child) =>
          value.todosCount == 0 ? child : TodoList(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Oh no! you have no todos',
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(height: 24.0),
              RaisedButton(
                shape: StadiumBorder(),
                color: Colors.blueGrey.shade200,
                child: Icon(Icons.add, color: Colors.teal.shade600),
                onPressed: () {
                  showBottomSheet(
                    elevation: 8.0,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) => Container(
                      height: 600.0,
                      decoration: BoxDecoration(color: Colors.blueGrey),
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  'Create a new todo',
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              ),
                              SizedBox(
                                height: 36.0,
                              ),
                              Padding(
                                padding: EdgeInsets.all(16.0),
                                child: InputTextField(
                                    context: context,
                                    onSaved: (value) => _title = value,
                                    labelText: 'Title',
                                    hintText: 'Title',
                                    textInputAction: TextInputAction.next,
                                    textInputType: TextInputType.text,
                                    autoValidate: false,
                                    autoFocus: false,
                                    onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                                    validator: (value) => value.isEmpty
                                        ? 'Invalid Todo Title'
                                        : null,
                                    textCapitalization: TextCapitalization.none),
                              ),
                              SizedBox(
                                height: 54.0,
                              ),
                              Padding(
                                padding: EdgeInsets.all(16.0),
                                child: InputTextField(
                                    context: context,
                                    onSaved: (value) => _createdBy = value,
                                    labelText: 'Name',
                                    hintText: 'Name',
                                    textInputAction: TextInputAction.done,
                                    textInputType: TextInputType.text,
                                    autoValidate: false,
                                    autoFocus: false,
                                    onSubmitted: (value) => FocusScope.of(context).unfocus(),
                                    validator: (value) => value.isEmpty
                                        ? 'Invalid Name'
                                        : null,
                                    textCapitalization: TextCapitalization.none),
                              ),
                              SizedBox(height: 54.0,),
                              Align(
                                alignment: Alignment.center,
                                child: RaisedButton(
                                  shape: StadiumBorder(),
                                  color: Colors.blueGrey.shade200,
                                  child: Icon(Icons.add,
                                      color: Colors.teal.shade600),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    _createdAt = DateTime.now().toIso8601String();
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      Provider.of<TodoModel>(context,
                                              listen: false)
                                          .createTodo(Todo(
                                              title: _title,
                                              createdBy: _createdBy,
                                              createdAt: _createdAt));
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showBottomSheet(GlobalKey<FormState> key, String title) async {}
}
