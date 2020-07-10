import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:todo/logic/auth_model.dart';
import 'package:todo/ui/pages/login.dart';
import 'package:todo/ui/widgets/submit_button.dart';

import 'test_utils.dart';

void main() {
  testWidgets('Login Page Flow', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<AuthModel>(
        create: (_) => AuthModel(),
        child: buildTestableWidget(LoginPage()),
      ),
    );

    // Test the presence of the email and password input fields
    expect(find.byType(TextFormField), findsNWidgets(2));
    // Test the presence of the signup and login buttons
    expect(find.text('Need an account?'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
    print('We are at the Login Page.');

    print('Tap the Need an account? button which renders the Sign Up Page(Widgets).');
    // Tap the signup button and test the Signup Page
    await tester.tap(find.text('Need an account?'));
    // Rebuild the widget
    await tester.pumpAndSettle();
    expect(find.byType(TextFormField), findsNWidgets(4));
    expect(find.text('Already have an account?'), findsOneWidget);
    expect(find.text('Sign Up'), findsOneWidget);
    print('We are at the Sign Up page');

    print('Tap the Already have an account? to go back to Login Page.');
    // Tap the sign in button and sign the user in
    await tester.tap(find.text('Already have an account?'));
    // Rebuild the widget
    await tester.pump();
    // Test if this the login page again
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('Need an account?'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
    print('We are at the Login Page.');

    // Find the Email and Password input fields and the Sign In button.
    final Finder password = find.widgetWithText(TextFormField, 'Password');
    final Finder email = find.widgetWithText(TextFormField, 'Email');
    final Finder signInButton = find.widgetWithText(RaisedButton, 'Sign In');

    print('fill in the Sign In form with wrong email and password');
    await tester.enterText(email, 'emailemailcom');
    await tester.enterText(password, '');
    await tester.tap(find.widgetWithText(RaisedButton, 'Sign In'));
    await tester.pumpAndSettle();
    expect(find.text('Invalid email address'), findsOneWidget);
    expect(find.text('Invalid Password. Password cannot be empty'),
        findsOneWidget);
    print('email and passwords are wrong and their error messages were found.');

    print('fill in the Sign In form with wrong email');
    await tester.enterText(email, 'emailemailcom');
    await tester.enterText(password, 'password@pass');
    await tester.tap(find.widgetWithText(RaisedButton, 'Sign In'));
    await tester.pumpAndSettle();
    expect(find.text('Invalid email address'), findsOneWidget);
    expect(find.text('Invalid Password. Password cannot be empty'),
        findsNothing);
    print('email is wrong and the error message is found');

    print('fill in the Sign In form with wrong password');
    await tester.enterText(email, 'email@email.com');
    await tester.enterText(password, '');
    await tester.tap(find.widgetWithText(RaisedButton, 'Sign In'));
    await tester.pumpAndSettle();
    expect(find.text('Invalid email address'), findsNothing);
    expect(find.text('Invalid Password. Password cannot be empty'),
        findsOneWidget);
    print('password is wrong and the error message is found.');

    print('fill in the Sign In form with correct email and password');
    await tester.enterText(email, 'email@email.com');
    await tester.enterText(password, 'password@123');
    await tester.tap(find.widgetWithText(RaisedButton, 'Sign In'));
    await tester.pumpAndSettle();
    expect(find.text('Invalid email address'), findsNothing);
    expect(
        find.text('Invalid Password. Password cannot be empty'), findsNothing);
    print('credentials are valid and no error messages were found');

    print('Tap the Sign in button and check if the snack bar appear');
    await tester.tap(signInButton);
    await tester.pumpAndSettle();
    expect(find.byType(SnackBar), findsOneWidget);
    print('Snack bar is found');
  });
}
