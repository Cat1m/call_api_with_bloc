import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:call_api/model/photo_model.dart';

import 'package:call_api/utils/utils.dart';
import 'package:http/http.dart' as http;

class PhotosRepository {
  Future<List<PhotoModel>> fetchPhotos() async {
    try {
      final response = await http.get(Uri.parse(ApiUrl.getUrl(Url.photos))).timeout(const Duration(seconds: 10));
      final body = json.decode(response.body) as List;

      if (response.statusCode == 200) {
        return body.map((dynamic json) {
          final map = json as Map<String, dynamic>;
          return PhotoModel(
            albumId: map['albumId'] as int,
            id: map['id'] as int,
            title: map['title'] as String,
            url: map['url'] as String,
            thumbnailUrl: map['thumbnailUrl'] as String,
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
