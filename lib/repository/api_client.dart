import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:call_api/model/posts_model.dart';
import 'package:call_api/model/photo_model.dart';
import 'package:call_api/utils/utils.dart';

class ApiClient {
  final http.Client _httpClient;

  ApiClient(this._httpClient);

  Future<List<PostModel>> fetchPosts() async {
    return await _fetchData<PostModel>(
      Url.posts,
      (json) => PostModel.fromJson(json),
    );
  }

  Future<List<PhotoModel>> fetchPhotos() async {
    return await _fetchData<PhotoModel>(
      Url.photos,
      (json) => PhotoModel.fromJson(json),
    );
  }

  Future<List<T>> _fetchData<T>(Url urlType, T Function(Map<String, dynamic>) parser) async {
    try {
      final response = await _httpClient.get(Uri.parse(ApiUrl.getUrl(urlType))).timeout(const Duration(seconds: 10));
      final body = json.decode(response.body) as List;

      if (response.statusCode == 200) {
        return body.map((dynamic json) => parser(json)).toList();
      }
    } on SocketException {
      await Future.delayed(const Duration(milliseconds: 1800));
      throw Exception('No Internet Connection');
    } on TimeoutException {
      throw Exception('');
    }

    throw Exception('Error fetching data');
  }
}
