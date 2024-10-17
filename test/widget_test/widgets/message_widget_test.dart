import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test/widgets/message_widget.dart';

void main() {
  testWidgets('測試按鈕點擊後跳出SnackBar訊息', (WidgetTester tester) async {
    // 構建一個簡單的 Widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: MessageButton(),
        ),
      ),
    );

    // 檢查按鈕是否存在
    expect(find.byType(ElevatedButton), findsOne);
    expect(find.byKey(const Key('message-button')), findsOne);
    expect(find.text('顯示訊息'), findsOneWidget);
    expect(find.byType(Text), findsAny);

    // 模擬按下按鈕
    await tester.tap(find.byKey(const Key('message-button')));

    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.textContaining('妳好'), findsAtLeastNWidgets(1));
    // expect(find.byType(ElevatedButton), findsNothing);
  });
}
