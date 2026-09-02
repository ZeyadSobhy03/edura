// This is a basic Flutter widgets test.
//
// To perform an interaction with a widgets in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widgets
// tree, read text, and verify that the values of widgets properties are correct.

import 'package:edura/edura_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Edura app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const EduraApp());

    expect(find.byType(EduraApp), findsOneWidget);
  });
}
