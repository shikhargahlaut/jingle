import 'package:flutter_test/flutter_test.dart';
import 'package:jingle/app/app.dart';

void main() {
  testWidgets('App renders test', (WidgetTester tester) async {
    await tester.pumpWidget(const JingleApp());
    expect(find.byType(JingleApp), findsOneWidget);
  });
}
