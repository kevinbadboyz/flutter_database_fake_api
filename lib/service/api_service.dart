import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:latihan_database_fake_api/models/post_model.dart';

import '../response/post_response.dart';

class ApiService {
  Future<PostResponse?> getPosts() async {
    try {
      final response = await Dio().get('https://tim100.cv4pagia.site/api/post');
      // get('http://10.0.2.2:8000/api/post');
      // get('https://jsonplaceholder.typicode.com/posts');
      debugPrint('GET POST : ${response.data['data']}');
      return PostResponse.fromJson(response.data['data']);
    } on DioException catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<PostModel?> createPost(String title, String body) async {
    try {
      final response = await Dio().post('https://tim100.cv4pagia.site/api/post',
          data: {'title': title, 'body': body});
      debugPrint('New POST : ${response.data['data']}');
      if (response.statusCode == 201) {
        return PostModel(
            id: int.tryParse(response.data['id'].toString()) ?? 0,
            title: response.data['title'],
            body: response.data['body']);
      }
      return null;
    } on DioException catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<PostModel?> updatePost(int id, String title, String body) async {
    try {
      final response = await Dio().put('https://tim100.cv4pagia.site/api/post/${id}',
          data: {'title': title, 'body': body});
      debugPrint('Update POST : ${response.data['data']}');
      if (response.statusCode == 200) {
        return PostModel(
            id: int.tryParse(response.data['id'].toString()) ?? 0,
            title: response.data['title'],
            body: response.data['body']);
      }
      return null;
    } on DioException catch (e) {
      debugPrint(e.toString());
    }
  }
}
