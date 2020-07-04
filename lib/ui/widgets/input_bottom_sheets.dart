import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/logic/Item.dart';
import 'package:todo/logic/Todo.dart';
import 'package:todo/logic/todo_model.dart';
import 'input_text_field.dart';
import 'submit_button.dart';

createTodoBottomSheet(BuildContext context, GlobalKey<FormState> formKey,
    String title, String createdBy, String createdAt) {
  showModalBottomSheet(
    elevation: 8.0,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    isDismissible: true,
    context: context,
    builder: (context) => Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.6,
        maxChildSize: 1.0,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade300,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8.0),
              topLeft: Radius.circular(8.0),
            ),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 38.0),
            controller: scrollController,
            child: Form(
              key: formKey,
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
                    height: 16.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: InputTextField(
                        context: context,
                        onSaved: (value) => title = value,
                        labelText: 'Title',
                        hintText: 'Title',
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        autoValidate: false,
                        autoFocus: false,
                        onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                        validator: (value) =>
                        value.isEmpty ? 'Invalid Todo Title' : null,
                        textCapitalization: TextCapitalization.none),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: InputTextField(
                        context: context,
                        onSaved: (value) => createdBy = value,
                        labelText: 'Name',
                        hintText: 'Name',
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.text,
                        autoValidate: false,
                        autoFocus: false,
                        onSubmitted: (value) =>
                            FocusScope.of(context).unfocus(),
                        validator: (value) =>
                        value.isEmpty ? 'Invalid Name' : null,
                        textCapitalization: TextCapitalization.none),
                  ),
                  SizedBox(
                    height: 36.0,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomButton(
                      shape: StadiumBorder(),
                      color: Colors.blueGrey.shade200,
                      child: Icon(
                        Icons.add,
                        color: Colors.teal.shade600,
                        size: 36.0,
                      ),
                      onPressed: () {
                        createdAt = DateTime.now()
                            .toString()
                            .substring(0, 16)
                            .replaceAll('-', '/');
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          Navigator.of(context).pop();
                          Provider.of<TodoModel>(context, listen: false)
                              .createTodo(Todo(
                              id: 1,
                              title: title,
                              createdBy: createdBy,
                              createdAt: createdAt));
                          Provider.of<TodoModel>(context, listen: false)
                              .createTodo(Todo(
                              id: 2,
                              title: title,
                              createdBy: createdBy,
                              createdAt: createdAt));
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

createItemBottomSheet(BuildContext context, int todoId, GlobalKey<FormState> formKey,
    String content, String createdAt) {
  showModalBottomSheet(
    elevation: 8.0,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    isDismissible: true,
    context: context,
    builder: (context) => Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.6,
        maxChildSize: 1.0,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade300,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8.0),
              topLeft: Radius.circular(8.0),
            ),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 38.0),
            controller: scrollController,
            child: Form(
              key: formKey,
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
                    height: 16.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: InputTextField(
                        context: context,
                        onSaved: (value) => content = value,
                        labelText: 'Content',
                        hintText: 'Content',
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        autoValidate: false,
                        autoFocus: false,
                        onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                        validator: (value) =>
                        value.isEmpty ? 'Invalid Todo Item' : null,
                        textCapitalization: TextCapitalization.none),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomButton(
                      shape: StadiumBorder(),
                      color: Colors.blueGrey.shade200,
                      child: Icon(
                        Icons.add,
                        color: Colors.teal.shade600,
                        size: 36.0,
                      ),
                      onPressed: () {
                        createdAt = DateTime.now()
                            .toString()
                            .substring(0, 16)
                            .replaceAll('-', '/');
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          Navigator.of(context).pop();
                          var lastId = Provider.of<TodoModel>(context, listen: false).itemsModel.items.length;
                          Provider.of<TodoModel>(context, listen: false)
                              .addItem(Item(id: lastId+1, todoId: todoId, content: content, status: false));
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}