import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:money_splitter/data/app_database.dart';
import 'package:money_splitter/data/profile_repository.dart';
import 'package:money_splitter/features/editor/editor_screen.dart';

void main() {
  testWidgets('adds a dynamic splitter and calculates its amount', (
    WidgetTester tester,
  ) async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(database.close);
    final repository = ProfileRepository(database);

    await tester.pumpWidget(
      MaterialApp(home: EditorScreen(repository: repository)),
    );

    expect(find.text('Capital'), findsOneWidget);
    expect(find.text('Remaining · 100%'), findsOneWidget);
    final amountField = find.widgetWithText(TextField, 'Amount');
    expect(tester.widget<TextField>(amountField).controller?.text, isEmpty);

    await tester.tap(find.byTooltip('Add split'));
    await tester.pump();

    expect(find.text('Split name'), findsOneWidget);
    await tester.enterText(amountField, '7000');
    expect(tester.widget<TextField>(amountField).controller?.text, '7,000');
    final percentField = find.widgetWithText(TextField, 'Percent');
    final maximumButton = find.byTooltip('Set maximum percentage');
    expect(maximumButton, findsOneWidget);
    expect(find.byTooltip('Set minimum percentage'), findsOneWidget);
    final maximumIconButton = find.ancestor(
      of: find.byIcon(Icons.last_page),
      matching: find.byType(IconButton),
    );
    tester.widget<IconButton>(maximumIconButton).onPressed!();
    await tester.pump();
    expect(tester.widget<TextField>(percentField).controller?.text, '100');
    final minimumIconButton = find.ancestor(
      of: find.byIcon(Icons.first_page),
      matching: find.byType(IconButton),
    );
    tester.widget<IconButton>(minimumIconButton).onPressed!();
    await tester.pump();
    expect(tester.widget<TextField>(percentField).controller?.text, '1');
    await tester.enterText(percentField, '50');
    await tester.pump();

    expect(find.text('₱3,500.00'), findsOneWidget);
    await tester.drag(find.byType(ListView), const Offset(0, -600));
    await tester.pump();
    expect(find.text('Remaining · 50%'), findsOneWidget);
  });
}
