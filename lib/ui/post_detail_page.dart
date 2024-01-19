import 'package:flutter/material.dart';
import 'package:latihan_database_fake_api/models/post_model.dart';
import 'package:latihan_database_fake_api/ui/post_create_page.dart';

class PostDetailPage extends StatelessWidget {
  PostModel postModel;
  PostDetailPage({super.key, required this.postModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text(postModel.title.toString()),
                  subtitle: Text(postModel.body.toString()),
                ),
                ButtonBar(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PostCreatePage(
                                        postModel: postModel,
                                      )));
                        },
                        child: Text('Ubah')),
                    OutlinedButton(onPressed: () {}, child: Text('Hapus'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
