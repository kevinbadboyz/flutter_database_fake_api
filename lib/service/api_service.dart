import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../response/post_response.dart';

class ApiService{
  Future<PostResponse?> getAllPost() async{
    try{
      var response = await Dio().get('https://jsonplaceholder.typicode.com/posts');
      debugPrint('GET Response : ${response.data}');
      return PostResponse.fromJson(response.data);
    }on DioException catch(e){
      debugPrint(e.toString());
    }
  }
}