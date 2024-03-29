import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:call_api/model/posts_model.dart';
import 'package:call_api/utils/utils.dart';
import 'package:http/http.dart' as http;

class PostRepository {
  Future<List<PostModel>> fetchPost() async {
    try {
      final response = await http.get(Uri.parse(ApiUrl.getUrl(Url.posts))).timeout(const Duration(seconds: 10));
      final body = json.decode(response.body) as List;

      if (response.statusCode == 200) {
        return body.map((dynamic json) {
          final map = json as Map<String, dynamic>;
          return PostModel(
            userId: map['userId'] as int,
            id: map['id'] as int,
            title: map['title'] as String,
            body: map['body'] as String,
          );
        }).toList();
      }
    } on SocketException {
      await Future.delayed(const Duration(milliseconds: 1800));
      throw Exception('No Internet Connection');
    } on TimeoutException {
      throw Exception('');
    }

    throw Exception('error fetching data');
  }
}
