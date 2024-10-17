import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test/quiz_screen.dart';

import 'matchers/size_matcher.dart';

void main() {
  final stateModel = QuizStateModel();

  testWidgets('測試多選題應用的問題顯示和答案選擇邏輯', (WidgetTester tester) async {
    // 構建測試用的 Widget
    await tester.pumpWidget(
      MaterialApp(
        home: QuizScreen(
          stateModel: stateModel,
        ),
      ),
    );

    // 1. 檢查問題是否正確顯示
    expect(find.text('Flutter 是哪一年推出的？'), findsOneWidget);

    // 2. 檢查是否顯示了所有選項
    expect(find.text('2015'), findsOneWidget);
    expect(find.text('2017'), findsOneWidget);
    expect(find.text('2019'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsAtLeast(3));

    // 3. 模擬點擊正確答案
    await tester.tap(find.text('2017'));
    await tester.pump(); // 觸發重繪

    // 4. 檢查是否顯示正確答案的反饋
    expect(find.text('正確！'), findsOneWidget);
    expect(find.text('錯誤，請再試一次。'), findsNothing);

    // 5. 模擬點擊錯誤答案
    await tester.tap(find.text('2015'));
    await tester.pump(); // 觸發重繪

    // 6. 檢查是否顯示錯誤答案的反饋
    expect(find.text('錯誤，請再試一次。'), findsOneWidget);
    expect(find.text('正確！'), findsNothing);
  });

  testWidgets('檢查編號元件的大小是否正確', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: QuizScreen(
          stateModel: stateModel,
        ),
      ),
    );

    // 使用自定義的SizeMatcher檢查大小是否正確
    expect(
      tester.getSize(find.byKey(const ValueKey('number-0'))),
      hasSize(const Size(32.0, 32.0)),
    );
  });
}
