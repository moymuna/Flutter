import 'package:flutter_test/flutter_test.dart';
import 'package:myflutter/main.dart';
import 'package:myflutter/page/login_page.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that we start at the login page.
    expect(find.byType(LoginPage), findsOneWidget);
  });
}
