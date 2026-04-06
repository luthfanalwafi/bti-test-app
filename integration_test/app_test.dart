import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:bti_test_app/main.dart';

import 'test_key.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Full user flow test', (WidgetTester tester) async {
    await tester.pumpWidget(MainApp());
    await tester.pumpAndSettle();

    // LOGIN
    Finder loginButton = find.byKey(keyLoginBtn);
    for (int i = 0; i < 10; i++) {
      await tester.pump(Duration(seconds: 1));
      if (loginButton.evaluate().isNotEmpty) {
        break;
      }
    }
    expect(loginButton, findsOneWidget);
    await tester.tap(loginButton.first);
    await tester.pumpAndSettle();

    // BROWSE NEWS
    Finder newsItem = find.byKey(keyNewsItem);
    for (int i = 0; i < 10; i++) {
      await tester.pump(Duration(seconds: 1));
      if (newsItem.evaluate().isNotEmpty) {
        break;
      }
    }
    expect(newsItem, findsWidgets);
    await tester.tap(newsItem.first);
    await tester.pumpAndSettle();

    // BOOKMARK
    Finder bookmarkButton = find.byKey(keyBookmarkBtn);
    for (int i = 0; i < 10; i++) {
      await tester.pump(Duration(seconds: 1));
      if (bookmarkButton.evaluate().isNotEmpty) {
        break;
      }
    }
    expect(bookmarkButton, findsOneWidget);
    await tester.tap(bookmarkButton);
    await tester.pumpAndSettle();

    // OPEN CHAT
    Finder chatButton = find.byKey(keyOpenChat);
    for (int i = 0; i < 10; i++) {
      await tester.pump(Duration(seconds: 1));
      if (chatButton.evaluate().isNotEmpty) {
        break;
      }
    }
    expect(chatButton, findsOneWidget);
    await tester.tap(chatButton);
    await tester.pumpAndSettle();

    // SEND MESSAGE
    final messages = ["hello", "help", "order"];
    for (final msg in messages) {
      await tester.enterText(find.byKey(keyInputMsg), msg);
      await tester.tap(find.byKey(keySendMsgBtn));
      await tester.pump();
      await tester.pump(Duration(seconds: 3));
      await tester.pumpAndSettle();
    }
    expect(find.text("order"), findsOneWidget);
  });
}
