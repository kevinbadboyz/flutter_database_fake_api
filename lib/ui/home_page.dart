import 'package:flutter/material.dart';
import 'package:latihan_database_fake_api/ui/post_create_page.dart';
import 'package:latihan_database_fake_api/ui/post_detail_page.dart';

import '../models/post_model.dart';
import '../response/post_response.dart';
import '../service/api_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Post'),
      ),
      // Tambahkan widget FloatingActionButton untuk membuat transaksi POST ke halaman Form Post
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          debugPrint('---------- Tambah Data ----------');
          // Panggil halaman PostCreatePage untuk melakukan post data
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PostCreatePage()));
        },
      ),
      body: FutureBuilder(
        future: apiService.getPosts(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            PostResponse postResponse = snapshot.data;
            List<PostModel> listPost = postResponse.listPost;
            return ListView.builder(
                itemCount: listPost.length,
                itemBuilder: (context, index) {
                  PostModel postModel = listPost[index];
                  return ListTile(
                    onTap: () {
                      debugPrint('-------- Halaman Post Detail --------');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostDetailPage(
                                    postModel: postModel,
                                  )));
                    },
                    leading: CircleAvatar(
                      child: Text(postModel.id.toString()),
                    ),
                    title: Text(postModel.title.toString()),
                    subtitle: Text(listPost[index].body.toString()),
                  );
                });
          }
          return Container();
        },
      ),
    );
  }
}
