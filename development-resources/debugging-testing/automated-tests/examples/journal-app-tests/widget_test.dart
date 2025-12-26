// Basic widget test for the Journal App

import 'package:flutter_test/flutter_test.dart';
import 'package:journal_app/main.dart';

void main() {
  testWidgets('Journal app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const JournalApp());

    // Verify that the app initializes without errors
    expect(find.text('Personal Journal'), findsOneWidget);
  });
}
