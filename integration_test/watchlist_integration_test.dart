import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:watchlist_task6/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('finds text sorting', (WidgetTester tester) async {
    WidgetsFlutterBinding.ensureInitialized();
    await tester.pumpWidget(
      MaterialApp(
        home: MyApp(),
      ),
    );
    await tester.pumpAndSettle();
    // expect(find.text('Watchlist1'), findsOneWidget);
    // expect(find.text('Watchlist2'), findsNothing);
    // expect(find.text('Watchlist3'), findsNothing);

    expect(find.text('Sorting'), findsOneWidget);
  });
}
