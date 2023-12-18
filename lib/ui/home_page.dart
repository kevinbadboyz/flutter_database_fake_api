import 'package:flutter/material.dart';
import 'package:latihan_database_fake_api/models/post_model.dart';
import 'package:latihan_database_fake_api/response/post_response.dart';
import 'package:latihan_database_fake_api/service/api_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Post'),
      ),
      body: FutureBuilder(
        future: apiService.getAllPost(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error.toString()}'),
            );
          } else if (snapshot.hasData) {
            PostResponse postResponse = snapshot.data;
            List<PostModel> listPost = postResponse.listPost;
            return ListView.builder(
                itemCount: listPost.length, itemBuilder: (context, index) {
                  return ListTile(title: Text(listPost[index].title.toString()),);
            });
          }
          return Container();
        },
      ),
    );
  }
}
