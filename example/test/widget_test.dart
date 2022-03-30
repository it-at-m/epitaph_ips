// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:example/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.textContaining(': 0'), findsNWidgets(3));
    expect(find.textContaining(': 1'), findsNothing);
    expect(find.textContaining(': 2'), findsNothing);
    expect(find.textContaining(': 3'), findsNothing);

    // Tap the Buttons and trigger a frame.
    await tester.tap(find.textContaining('Add one'));
    await tester.tap(find.textContaining('Add two'));
    await tester.tap(find.textContaining('Add three'));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.textContaining(': 0'), findsNothing);
    expect(find.textContaining(': 1'), findsOneWidget);
    expect(find.textContaining(': 2'), findsOneWidget);
    expect(find.textContaining(': 3'), findsOneWidget);
  });
}
