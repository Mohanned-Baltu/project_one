import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:uni_project1/main.dart';

void main() {
  testWidgets('builds Cookly app', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
