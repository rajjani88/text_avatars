import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:text_avatars/text_avatars.dart';

void main() {
  group('UserAvatar Widget Tests', () {
    testWidgets('renders with userName', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: UserAvatar(userName: 'John Doe')),
        ),
      );

      expect(find.byType(UserAvatar), findsOneWidget);
      expect(find.text('JD'), findsOneWidget);
    });

    testWidgets('renders with single name', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: UserAvatar(userName: 'John')),
        ),
      );

      expect(find.text('J'), findsOneWidget);
    });

    testWidgets('renders with initialsText', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: UserAvatar(initialsText: 'AB')),
        ),
      );

      expect(find.text('AB'), findsOneWidget);
    });

    testWidgets('renders with custom size', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: UserAvatar(userName: 'Test User', size: 100.0)),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container).first);
      expect(container.constraints?.maxWidth, 100.0);
      expect(container.constraints?.maxHeight, 100.0);
    });

    testWidgets('renders with custom colors', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: UserAvatar(
              userName: 'Test User',
              backgroundColor: Colors.red,
              textColor: Colors.white,
            ),
          ),
        ),
      );

      expect(find.byType(UserAvatar), findsOneWidget);
    });

    testWidgets('falls back to ? when no data provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: UserAvatar())),
      );

      expect(find.text('?'), findsOneWidget);
    });

    testWidgets('handles empty userName', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: UserAvatar(userName: '')),
        ),
      );

      expect(find.text('?'), findsOneWidget);
    });

    testWidgets('handles network image URL', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: UserAvatar(
              profileUrl: 'https://example.com/avatar.jpg',
              userName: 'Fallback User',
            ),
          ),
        ),
      );

      expect(find.byType(UserAvatar), findsOneWidget);
      // Image widget should be attempting to load
      await tester.pump();
    });

    testWidgets('prioritizes initialsText over userName', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: UserAvatar(userName: 'John Doe', initialsText: 'XY'),
          ),
        ),
      );

      expect(find.text('XY'), findsOneWidget);
      expect(find.text('JD'), findsNothing);
    });
  });
}
