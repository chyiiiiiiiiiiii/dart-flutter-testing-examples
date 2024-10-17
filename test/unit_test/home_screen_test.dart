import 'package:flutter_test/flutter_test.dart';
import 'package:test/home_screen.dart';

void main() {
  group('加法函數測試', () {
    test('加法的基本情況', () {
      // 檢查正數相加
      expect(add(2, 3), equals(5));
    });

    test('處理零', () {
      // 加法中的零應該不改變結果
      expect(add(0, 5), equals(5));
      expect(add(5, 0), equals(5));
    });

    test('處理負數', () {
      // 負數相加應該返回正確結果
      expect(add(-2, -3), equals(-5));
      expect(add(-2, 3), equals(1));
    });
  });

  group('偶數判斷函數測試', () {
    test('檢查正數', () {
      expect(isEven(4), isTrue);
      expect(isEven(7), isFalse);
    });

    test('檢查零', () {
      // 零應該被視為偶數
      expect(isEven(0), isTrue);
    });

    test('檢查負數', () {
      // 負數也應該正確判斷
      expect(isEven(-2), isTrue);
      expect(isEven(-3), isFalse);
    });

    test('檢查大數字', () {
      // 測試非常大的數字
      expect(isEven(1000000), isTrue);
      expect(isEven(1000001), isFalse);
    });
  });

  group('計數器類別測試', () {
    test('初始值應為 0', () {
      final counter = Counter();
      expect(counter.value, equals(0));
    });

    test('增量操作', () {
      final counter = Counter();
      counter.increment();
      expect(counter.value, equals(1));

      counter.increment();
      expect(counter.value, equals(2));
    });

    test('減量操作', () {
      final counter = Counter();
      counter.decrement();
      expect(counter.value, equals(-1));

      counter.decrement();
      expect(counter.value, equals(-2));
    });

    test('增量和減量交替', () {
      final counter = Counter();
      counter.increment();
      counter.increment();
      counter.decrement();
      expect(counter.value, equals(1));
    });
  });

  group('非同步操作測試', () {
    test('正常處理', () async {
      final result = await processData();
      expect(result, equals(84));
    });

    test('模擬資料處理時發生錯誤', () async {
      expect(() => processDataWithError(), throwsException);
    });
  });
}
