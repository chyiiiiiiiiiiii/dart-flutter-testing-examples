import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/service/api_service.dart';

// 創建 Mock 類別
class MockApiService extends Mock implements ApiService {}

void main() {
  group('API 模擬測試', () {
    late final MockApiService apiService;

    setUpAll(() {
      apiService = MockApiService();
    });

    test('模擬返回資料', () async {
      // 設定當調用 fetchData 時，返回模擬資料
      when(() => apiService.fetchData()).thenAnswer(
        (value) async => 'The weather is bad.',
      );

      final data = await apiService.fetchData();

      // 驗證返回的是否是模擬資料
      expect(data, contains('bad'));
    });

    test('模擬錯誤返回', () async {
      // 模擬當調用 fetchData 時拋出異常
      when(() => apiService.fetchData()).thenThrow(Exception('API 錯誤'));

      // 驗證捕捉到的異常
      expect(() => apiService.fetchData(), throwsException);
    });
  });
}
