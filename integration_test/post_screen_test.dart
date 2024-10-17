import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/data/posts.dart';
import 'package:test/main.dart' as app;
import 'package:test/post_screen.dart';
import 'package:test/service/api_service.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('貼文牆測試', () {
    testWidgets('跳轉到貼文頁，進行貼文牆清單滾動，找到第30個貼文', (WidgetTester tester) async {
      // 啟動應用
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.text('Go to Post'));
      await tester.pumpAndSettle();

      // 1. 檢查頁面標題
      expect(find.text('貼文列表'), findsOneWidget);

      // 2. 檢查ListView元件
      expect(find.byType(ListView), findsOneWidget);

      // 3. 定位Scrollable元件
      // final scrollableFinder = find.byType(Scrollable);
      final scrollableFinder = find
          .descendant(
            of: find.byType(ListView),
            matching: find.byType(Scrollable),
          )
          .first;

      // 4. 滑動清單，尋找到第30個項目
      await tester.scrollUntilVisible(
        find.byKey(const ValueKey('item-29')),
        500,
        scrollable: scrollableFinder,
      );
    });

    testWidgets('跳轉到貼文頁，找到第2個貼文點擊愛心，愛心更新為紅色', (WidgetTester tester) async {
      // 使用模擬的ApiService類別
      apiService = MockApiService();

      // 偽造資料，執行likePost()時給予成功結果
      when(
        () => apiService.likePost(
          postName: any(named: 'postName'),
          newLikeStatus: any(named: 'newLikeStatus'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          '{"status": "success"}',
          200,
        ),
      );

      const postIndex = 1;
      final secondPost = postData.elementAt(postIndex).$2;

      // 啟動應用
      app.main();
      await tester.pumpAndSettle();

      // 跳轉到貼文頁面
      await tester.tap(find.text('Go to Post'));
      await tester.pumpAndSettle();

      // 檢查頁面標題
      expect(find.text('貼文列表'), findsOneWidget);

      // 檢查初始元件的存在與內容
      const firstItemKey = ValueKey('item-$postIndex');
      expect(find.byKey(firstItemKey), findsOneWidget);
      expect(find.text(secondPost.postName), findsOneWidget);
      expect(find.text('讚數：${secondPost.likeCount}'), findsOneWidget);

      // 點擊指定IconButton，觸發相關邏輯
      final iconButtonFinder =
          find.byKey(const ValueKey('icon-button-$postIndex'));
      await tester.tap(iconButtonFinder);
      await tester.pumpAndSettle();

      // 檢查Text元件的內容
      expect(
        tester
            .widget<Text>(find.byKey(const ValueKey('like-count-$postIndex')))
            .data,
        equals('讚數：${secondPost.likeCount + 1}'),
      );
      // 從指定IconButton取出Icon元件
      final iconFinder = tester.widget<Icon>(
        find.descendant(
          of: iconButtonFinder,
          matching: find.byType(Icon),
        ),
      );
      // 檢查Icon元件的內容
      expect(iconFinder.icon, equals(Icons.favorite));
      expect(iconFinder.color, equals(Colors.red));

      // 驗證likePost()方法呼叫過1次
      verify(() => apiService.likePost(
            postName: secondPost.postName,
            newLikeStatus: !secondPost.isLiked,
          )).called(1);
    });

    testWidgets('跳轉到貼文頁，找到第5個貼文點擊愛心，取消點讚，按讚數-1', (WidgetTester tester) async {
      // 使用模擬的ApiService類別
      apiService = MockApiService();

      // 偽造資料，執行likePost()時給予成功結果
      when(
        () => apiService.likePost(
          postName: any(named: 'postName'),
          newLikeStatus: any(named: 'newLikeStatus'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          '{"status": "success"}',
          200,
        ),
      );

      const postIndex = 4;
      final fifthPost = postData.elementAt(postIndex).$2;
      final likeCount = fifthPost.likeCount;

      // 啟動應用
      app.main();
      await tester.pumpAndSettle();

      // 跳轉到貼文頁面
      await tester.tap(find.text('Go to Post'));
      await tester.pumpAndSettle();

      // 檢查頁面標題
      expect(find.text('貼文列表'), findsOneWidget);

      // 檢查初始元件的存在與內容
      const firstItemKey = ValueKey('item-$postIndex');
      expect(find.byKey(firstItemKey), findsOneWidget);
      expect(find.text(fifthPost.postName), findsOneWidget);
      expect(find.text('讚數：$likeCount'), findsOneWidget);

      // 點擊指定IconButton，觸發相關邏輯
      await tester.tap(find.byKey(const ValueKey('icon-button-$postIndex')));
      await tester.pumpAndSettle();

      // 檢查Text元件的內容
      expect(
        tester
            .widget<Text>(find.byKey(const ValueKey('like-count-$postIndex')))
            .data,
        equals('讚數：${fifthPost.likeCount - 1}'),
      );
      // 從指定IconButton取出Icon元件
      final iconFinder = tester.widget<Icon>(
        find.descendant(
          of: find.byKey(const ValueKey('icon-button-$postIndex')),
          matching: find.byType(Icon),
        ),
      );
      // 檢查Icon元件的內容
      expect(iconFinder.icon, equals(Icons.favorite_border));
      expect(iconFinder.color, equals(Colors.grey));

      // 驗證likePost()方法呼叫過1次
      verify(() => apiService.likePost(
            postName: fifthPost.postName,
            newLikeStatus: !fifthPost.isLiked,
          )).called(1);
    });

    testWidgets('跳轉到貼文頁，找到第10個貼文點擊愛心，遇到網路請求錯誤，愛心跟按讚數沒有改變',
        (WidgetTester tester) async {
      // 使用模擬的ApiService類別
      apiService = MockApiService();

      // 偽造資料，執行likePost()時給予失敗結果
      when(
        () => apiService.likePost(
          postName: any(named: 'postName'),
          newLikeStatus: any(named: 'newLikeStatus'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          '{"status": "failure"}',
          400,
        ),
      );

      const postIndex = 9;
      final fifthPost = postData.elementAt(postIndex).$2;
      final likeCount = fifthPost.likeCount;

      // 啟動應用
      app.main();
      await tester.pumpAndSettle();

      // 跳轉到貼文頁面
      await tester.tap(find.text('Go to Post'));
      await tester.pumpAndSettle();

      // 檢查頁面標題
      expect(find.text('貼文列表'), findsOneWidget);

      // 檢查初始元件的存在與內容
      const firstItemKey = ValueKey('item-$postIndex');
      expect(find.byKey(firstItemKey), findsOneWidget);
      expect(find.text(fifthPost.postName), findsOneWidget);
      expect(find.text('讚數：$likeCount'), findsOneWidget);

      // 點擊指定IconButton，觸發相關邏輯
      await tester.tap(find.byKey(const ValueKey('icon-button-$postIndex')));
      await tester.pumpAndSettle();

      // 檢查Text元件的內容
      expect(
        tester
            .widget<Text>(find.byKey(const ValueKey('like-count-$postIndex')))
            .data,
        equals('讚數：${fifthPost.likeCount}'),
      );
      // 從指定IconButton取出Icon元件
      final revertedIconFinder = tester.widget<Icon>(
        find.descendant(
          of: find.byKey(const ValueKey('icon-button-$postIndex')),
          matching: find.byType(Icon),
        ),
      );
      // 檢查Icon元件的內容
      expect(revertedIconFinder.icon, equals(Icons.favorite_border));
      expect(revertedIconFinder.color, equals(Colors.grey));

      // 驗證likePost()方法呼叫過1次
      verify(() => apiService.likePost(
            postName: fifthPost.postName,
            newLikeStatus: !fifthPost.isLiked,
          )).called(1);
    });
  });
}
