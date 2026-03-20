// test/widget_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_kit/main.dart';

void main() {
  testWidgets('ZenithApp smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: ZenithApp()));

    // Verify that the app renders without crashing.
    expect(find.byType(ZenithApp), findsOneWidget);
  });
}
