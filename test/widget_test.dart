import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mechkonnect_auto_service_hub/main.dart';
import 'package:mechkonnect_auto_service_hub/app.dart';

void main() {
  group('MechKonnect App Tests', () {
    testWidgets('App should initialize without errors', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        const ProviderScope(
          child: MechKonnectApp(),
        ),
      );

      // Verify that the app loads
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('Splash screen should be displayed initially', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        const ProviderScope(
          child: MechKonnectApp(),
        ),
      );

      // Wait for the splash screen to load
      await tester.pumpAndSettle();

      // Verify that splash screen content is displayed
      expect(find.text('MechKonnect'), findsOneWidget);
      expect(find.text('Auto Service Hub'), findsOneWidget);
      expect(find.text('Connecting you to trusted mechanics...'), findsOneWidget);
    });

    testWidgets('App should use Material 3 theme', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MechKonnectApp(),
        ),
      );

      final MaterialApp app = tester.widget(find.byType(MaterialApp));
      expect(app.theme?.useMaterial3, isTrue);
      expect(app.darkTheme?.useMaterial3, isTrue);
    });
  });
}