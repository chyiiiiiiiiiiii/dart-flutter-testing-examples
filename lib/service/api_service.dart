import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

// 模擬一個簡單的 API
class ApiService {
  Future<String> fetchData() async {
    // 假設這裡發出了一個 API 請求
    return 'Today\'s weather is awesome!';
  }

  Future<Response> likePost(
      {required String postName, required bool newLikeStatus}) async {
    return http.post(
      Uri.parse('https://instag.com/postName/like'),
      body: jsonEncode({'liked': newLikeStatus}),
    );
  }
}
