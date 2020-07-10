import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:todo/logic/Item.dart';
import 'package:todo/logic/auth_model.dart';
import 'package:todo/logic/item_model.dart';
import 'package:todo/logic/todo_model.dart';
import 'package:todo/ui/widgets/empty_todo_list.dart';
import 'package:todo/ui/widgets/todo_list.dart';

import 'test_utils.dart';

void main() {
  testWidgets('Empty Todo Page Tests', (tester) async {
    BuildContext savedContext;
    await tester.pumpWidget(
      MultiProvider(
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
        child: Builder(builder: (context) {
          savedContext = context;
          return buildTestableWidget(EmptyTodoList());
        }),
      ),
    );

    final Finder newTodoButton = find.widgetWithText(RaisedButton, 'New Todo');
    final Finder createButton = find.widgetWithIcon(RaisedButton, Icons.add);
    final Finder titleField = find.widgetWithText(TextFormField, 'Title');
    final Finder nameField = find.widgetWithText(TextFormField, 'Name');
    final Finder contentField = find.widgetWithText(TextFormField, 'Content');
    final Finder addItemButton = find.widgetWithText(RaisedButton, 'Add Item');

    expect(find.text('Oh no! you have no todos'), findsOneWidget);
    expect(newTodoButton, findsOneWidget);
    print('We are at the Todos page but it is empty.');

    print('Tap the new todo button to create a new todo');
    await tester.tap(newTodoButton);
    await tester.pumpAndSettle();
    expect(find.text('Create a new todo'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(titleField, findsOneWidget);
    expect(nameField, findsOneWidget);
    expect(createButton, findsOneWidget);
    // Since the bottom sheet only covers the background this means the (create button) is still
    // in the render tree so it is expected to have 2 add buttons.
    expect(find.byType(RaisedButton), findsNWidgets(2));
    print('Bottom sheet containing the creation form is visible.');

    // Tap the add button with no input and test the error messages
    await tester.tap(createButton);
    await tester.pump();
    expect(find.text('Invalid Todo Title'), findsOneWidget);
    expect(find.text('Invalid Name'), findsOneWidget);
    print('Inputs are invalid and error messages are shown');

    // Enter input
    expect(titleField, findsOneWidget);
    expect(nameField, findsOneWidget);
    expect(createButton, findsOneWidget);

    await tester.enterText(titleField, 'Free6lack');
    await tester.enterText(nameField, '6lack');
    await tester.tap(createButton);
    await tester.pumpAndSettle();
    expect(Provider.of<TodoModel>(savedContext, listen: false).todosCount, 1);

    expect(find.text('Free6lack'), findsOneWidget);
    expect(addItemButton, findsNWidgets(1));
    expect(newTodoButton, findsNWidgets(1));
    print('Todo is created and now we are at the Todo List Page');

    // tap the first create button to create a new item
    await tester.tap(addItemButton);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Create a new todo item'), findsOneWidget);
    expect(contentField, findsOneWidget);
    expect(createButton, findsOneWidget);
    print('Create item bottom sheet is now visible');

    // Tap the create item button with no content and test the error messages
    await tester.tap(createButton);
    await tester.pump();

    expect(find.text('Invalid Todo Item'), findsOneWidget);
    print('Input are invalid and error message is shown');

    await tester.drag(find.byType(BottomSheet), Offset(0.0, 500.0));
    await tester.pump();
    await tester.pump(const Duration(seconds: 2));

    expect(find.text('Free6lack'), findsOneWidget);
    expect(addItemButton, findsOneWidget);
    print('bottom sheet dismissed');

    await tester.tap(newTodoButton);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Create a new todo'), findsOneWidget);
    expect(titleField, findsOneWidget);
    expect(nameField, findsOneWidget);
    expect(createButton, findsOneWidget);
    print('Create new Todo bottom sheet is now visible');

    await tester.enterText(titleField, 'Birds in the Trap');
    await tester.enterText(nameField, 'Travis Scott');
    await tester.tap(createButton);
    await tester.pump();
    await tester.pump(const Duration(seconds: 2));

    expect(find.text('Birds in the Trap'), findsOneWidget);
    expect(find.text('Free6lack'), findsOneWidget);
    expect(addItemButton, findsNWidgets(2));
    expect(newTodoButton, findsOneWidget);
    print('New todo created successfully');
  });
}
