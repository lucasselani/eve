import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class EveTester {
  static Future<Widget> createWidget(WidgetTester tester, Widget widget) async {
    final view = MaterialApp(home: widget);
    await tester.pumpWidget(view);
    await tester.pumpAndSettle();
    return view;
  }

  static Finder findByText(String text) => find.byWidgetPredicate(
      (widget) => widget is Text && widget.data.toString().contains(text));
}
