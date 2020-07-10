import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/logic/auth_model.dart';
import 'package:todo/logic/todo_model.dart';
import 'package:todo/logic/item_model.dart';
import 'test_utils.dart';
import 'package:todo/ui/widgets/todo_list.dart';

void main() {
  testWidgets('Todos Page Tests', (tester) async {
    BuildContext savedContext;
    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthModel(),
        ),
        Provider(
          create: (_) => ItemModel(),
        ),
        ChangeNotifierProxyProvider<ItemModel, TodoModel>(
          create: (_) => TodoModel(),
          update: (_, itemModel, todoModel) {
            todoModel.itemsModel = itemModel;
            return todoModel;
          },
        ),
      ],
      child: buildTestableWidget(Builder(
        builder: (context) {
          savedContext = context;
          return buildTestableWidget(TodoList());
        },
      )),
    ));

    final Finder newTodoButton = find.widgetWithText(RaisedButton, 'New Todo');
    final Finder addItemButton = find.widgetWithText(RaisedButton, 'Add Item');
    final Finder contentField = find.widgetWithText(TextFormField, 'Content');
    final Finder titleField = find.widgetWithText(TextFormField, 'Title');
    final Finder nameField = find.widgetWithText(TextFormField, 'Name');
    final Finder createButton = find.widgetWithIcon(RaisedButton, Icons.add);
    final Finder deleteButton = find.widgetWithIcon(IconButton, Icons.delete);

    expect(newTodoButton, findsOneWidget);
    expect(addItemButton, findsNothing);
    expect(contentField, findsNothing);
    expect(createButton, findsNothing);
    print('We Are at Todos List Page but it\'s empty so let\'s populate it');

    await tester.tap(newTodoButton);
    await tester.pumpAndSettle();
    await tester.enterText(titleField, 'Free6lack');
    await tester.enterText(nameField, '6lack');
    await tester.tap(createButton);
    await tester.pumpAndSettle();
    expect(Provider.of<TodoModel>(savedContext, listen: false).todosCount, 1);
    expect(find.text('Free6lack'), findsOneWidget);
    expect(deleteButton, findsOneWidget);
    expect(addItemButton, findsNWidgets(1));
    expect(newTodoButton, findsNWidgets(1));
    print('Todo added successfully to the list');

    await tester.tap(addItemButton);
    await tester.pump();
    await tester.pump(const Duration(seconds: 2));

    expect(find.text('Create a new todo item'), findsOneWidget);
    expect(contentField, findsOneWidget);
    expect(createButton, findsOneWidget);
    print('Create Item Bottom sheet visible');

    await tester.enterText(contentField, '18');
    await tester.tap(createButton);
    await tester.pump();
    await tester.pump(const Duration(seconds: 5));

    expect(createButton, findsNothing);
    expect(contentField, findsNothing);
    expect(find.text('Free6lack'), findsOneWidget);
    expect(find.text('18'), findsOneWidget);
    print('Item added successfully');

    await tester.tap(newTodoButton);
    await tester.pump();
    await tester.pump(const Duration(seconds: 5));
    await tester.enterText(titleField, 'Moon Man');
    await tester.enterText(nameField, 'Moon Man');
    await tester.tap(createButton);
    await tester.pump();
    await tester.pump(const Duration(seconds: 5));

    expect(Provider.of<TodoModel>(savedContext, listen: false).todosCount, 2);
    expect(createButton, findsNothing);
    expect(find.text('Free6lack'), findsOneWidget);
    expect(find.text('18'), findsOneWidget);
    expect(find.text('Moon Man'), findsOneWidget);
    expect(addItemButton, findsNWidgets(2));
    expect(deleteButton, findsNWidgets(2));
    expect(newTodoButton, findsOneWidget);
    print('New Todo created successfully');

    await tester.tap(addItemButton.last);
    await tester.pump();
    await tester.pump(const Duration(seconds: 5));
    expect(contentField, findsOneWidget);
    await tester.enterText(contentField, 'Adventures of Moon Man');
    expect(createButton, findsOneWidget);
    await tester.tap(createButton);
    await tester.pump();
    await tester.pump(const Duration(seconds: 5));

    expect(find.text('Free6lack'), findsOneWidget);
    expect(find.text('Moon Man'), findsOneWidget);
    expect(find.text('18'), findsOneWidget);
    expect(find.text('Adventures of Moon Man'), findsOneWidget);
    expect(addItemButton, findsNWidgets(2));
    expect(deleteButton, findsNWidgets(2));
    expect(newTodoButton, findsOneWidget);
    expect(createButton, findsNothing);
    expect(find.byType(Checkbox), findsNWidgets(2));
    expect(find.byIcon(Icons.clear), findsNWidgets(2));
    print('Item added successfully to the second todo');

    await tester.drag(find.byType(Dismissible).first, Offset(-500.0, 0.0));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 5));

    expect(find.widgetWithText(SnackBar, 'Deleted 18 from List'), findsOneWidget);
    expect(find.text('Free6lack'), findsOneWidget);
    expect(find.text('Moon Man'), findsOneWidget);
    expect(find.text('18'), findsNothing);
    expect(find.text('Adventures of Moon Man'), findsOneWidget);
    expect(addItemButton, findsNWidgets(2));
    expect(deleteButton, findsNWidgets(2));
    expect(newTodoButton, findsOneWidget);
    expect(createButton, findsNothing);
    expect(find.byType(Checkbox), findsOneWidget);
    expect(find.byIcon(Icons.clear), findsOneWidget);
    await tester.pump(const Duration(seconds: 10)); // wait for dismissible to be removed from tree
    expect(find.byType(Dismissible), findsOneWidget);
    print('Item \'18\' removed successfully by dragging dismissible');

    await tester.tap(find.byIcon(Icons.clear));
    await tester.pump();
    await tester.pump(const Duration(seconds: 5));

    expect(find.text('Free6lack'), findsOneWidget);
    expect(find.text('Moon Man'), findsOneWidget);
    expect(find.text('18'), findsNothing);
    expect(find.text('Adventures of Moon Man'), findsNothing);
    expect(addItemButton, findsNWidgets(2));
    expect(deleteButton, findsNWidgets(2));
    expect(newTodoButton, findsOneWidget);
    expect(createButton, findsNothing);
    expect(find.byType(Checkbox), findsNothing);
    expect(find.byIcon(Icons.clear), findsNothing);
    await tester.pump(const Duration(seconds: 10)); // wait for dismissible to be removed from tree
    expect(find.byType(Dismissible), findsNothing);
    print('Item \'Adventures of Moon Man\' removed successfully by tapping clear button');

    await tester.tap(addItemButton.first);
    await tester.pump();
    await tester.pump(const Duration(seconds: 5));
    expect(contentField, findsOneWidget);
    await tester.enterText(contentField, 'Slim');
    await tester.tap(createButton);
    await tester.pump();
    await tester.pump(const Duration(seconds: 5));
    expect(find.text('Slim'), findsOneWidget);

    await tester.tap(addItemButton.first);
    await tester.pump();
    await tester.pump(const Duration(seconds: 5));
    expect(contentField, findsOneWidget);
    await tester.enterText(contentField, 'Slim 2');
    await tester.tap(createButton);
    await tester.pump();
    await tester.pump(const Duration(seconds: 5));
    expect(find.text('Slim'), findsOneWidget);
    expect(find.text('Slim 2'), findsOneWidget);

    await tester.tap(addItemButton.last);
    await tester.pump();
    await tester.pump(const Duration(seconds: 5));
    expect(contentField, findsOneWidget);
    await tester.enterText(contentField, 'Roger');
    await tester.tap(createButton);
    await tester.pump();
    await tester.pump(const Duration(seconds: 5));
    expect(find.text('Slim'), findsOneWidget);
    expect(find.text('Slim 2'), findsOneWidget);
    expect(find.text('Roger'), findsOneWidget);


    await tester.ensureVisible(addItemButton.last); // scroll the screen until button is visible
    await tester.pump(const Duration(seconds: 5));
    await tester.tap(addItemButton.last);
    await tester.pump();
    await tester.pump(const Duration(seconds: 5));
    await tester.enterText(contentField, 'Roger 2');
    await tester.tap(createButton);
    await tester.pump();
    await tester.pump(const Duration(seconds: 5));
    expect(find.text('Slim'), findsOneWidget);
    expect(find.text('Slim 2'), findsOneWidget);
    expect(find.text('Roger'), findsOneWidget);
    expect(find.text('Roger 2'), findsOneWidget);
    expect(find.byIcon(Icons.clear), findsNWidgets(4));
    expect(find.byType(Dismissible), findsNWidgets(4));
    expect(find.byType(Checkbox), findsNWidgets(4));
    print('Added multiple items to each todo successfully');

    final Finder secondItem = find.byType(Dismissible).at(1);
    await tester.ensureVisible(secondItem);
    await tester.pump(const Duration(seconds: 5));
    await tester.drag(secondItem, Offset(-500.0, 0));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 5));
//    print(Provider.of<TodoModel>(savedContext, listen: false).items);
    expect(find.text('Slim'), findsOneWidget);
    expect(find.text('Slim 2'), findsNothing);
    expect(find.text('Roger'), findsOneWidget);
    expect(find.text('Roger 2'), findsOneWidget);
    expect(find.byIcon(Icons.clear), findsNWidgets(3));
    expect(find.byType(Checkbox), findsNWidgets(3));
    await tester.pump(const Duration(seconds: 10)); // wait for dismissible to be removed from tree
    expect(find.byType(Dismissible), findsNWidgets(3));
    print('Removed second item of the first todo successfully');

    expect(tester.widget<Checkbox>(find.byType(Checkbox).first).value, false);
    expect(Provider.of<TodoModel>(savedContext, listen: false).items[0].status, false);
    print('Slim todo item status value is false');

    await tester.tap(find.text('Slim'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 5));

    expect(tester.widget<Checkbox>(find.byType(Checkbox).first).value, true);
    expect(Provider.of<TodoModel>(savedContext, listen: false).items[0].status, true);
    print('Tapping text change the value of the checkbox and the item status value');
    print('Slim todo item status value is true');

    await tester.tap(find.byType(Checkbox).first);
    await tester.pump();
    await tester.pump(const Duration(seconds: 5));

    expect(tester.widget<Checkbox>(find.byType(Checkbox).first).value, false);
    expect(Provider.of<TodoModel>(savedContext, listen: false).items[0].status, false);
    print('tapping the checkbox change its value and the item status');

    await tester.tap(deleteButton.last);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 5));

    expect(Provider.of<TodoModel>(savedContext, listen: false).todosCount, 1);
    expect(Provider.of<TodoModel>(savedContext, listen: false).itemsCount, 1);
    expect(find.text('Moon Man'), findsNothing);
    expect(addItemButton, findsOneWidget);
    expect(deleteButton, findsOneWidget);
    expect(find.text('Free6lack'), findsOneWidget);
    expect(find.byType(Checkbox), findsOneWidget);
    expect(find.byIcon(Icons.clear), findsOneWidget);
    print('Tapping the delete button deletes the todo and its items successfully');
    debugDumpApp();
  });
}
