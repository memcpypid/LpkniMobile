import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:lpkni/main.dart' as app;
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Full flow: login -> dashboard -> transaksi -> buat pesanan -> checout ->',
      (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    // LOGIN PAGE
    final usernameField = find.byKey(const Key('usernameField'));
    final passwordField = find.byKey(const Key('passwordField'));
    final loginButton = find.byKey(const Key('loginButton'));

    await tester.enterText(usernameField, 'distributor@mail.com');
    await tester.enterText(passwordField, '123123');
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    expect(find.text('Dashboard'), findsOneWidget);

    // DASHBOARD -> TRANSAKSI
    final transaksiButton = find.byKey(const Key('transaksiButton'));
    await tester.tap(transaksiButton);
    await tester.pumpAndSettle();

    expect(find.text('Daftar Transaksi'), findsOneWidget);

    // LOGOUT
    final logoutButton = find.byKey(const Key('logoutButton'));
    await tester.tap(logoutButton);
    await tester.pumpAndSettle();

    expect(find.text('Login'), findsOneWidget);
  });
}
