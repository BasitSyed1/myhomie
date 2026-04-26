import 'package:flutter_test/flutter_test.dart';

import 'package:my_homie/app/app.dart';

void main() {
  testWidgets('App builds without throwing', (WidgetTester tester) async {
    await tester.pumpWidget(const MyHomieApp());
  });
}
