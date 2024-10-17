import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// 對外公開的函數，使用_SizeMatcher比對Widget的大小
Matcher hasSize(Size expectedSize) => _SizeMatcher(expectedSize);

/// 自定義的SizeMatcher用來比對畫面Widget與預期大小是否符合
class _SizeMatcher extends Matcher {
  final Size expectedSize;

  _SizeMatcher(this.expectedSize);

  @override
  Description describe(Description description) {
    return description.add('$expectedSize');
  }

  @override
  bool matches(dynamic item, Map matchState) {
    if (item is! Size) return false;

    return item.width == expectedSize.width &&
        item.height == expectedSize.height;
  }

  @override
  Description describeMismatch(
      item, Description mismatchDescription, Map matchState, bool verbose) {
    return mismatchDescription.add('Widget size was "$item"');
  }
}
