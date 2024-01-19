import 'package:flutter/material.dart';
import 'package:latihan_database_fake_api/service/api_service.dart';
import 'package:latihan_database_fake_api/ui/home_page.dart';
import 'package:latihan_database_fake_api/ui/post_detail_page.dart';

import '../models/post_model.dart';

class PostCreatePage extends StatefulWidget {
  PostModel? postModel;
  PostCreatePage({super.key, this.postModel});

  @override
  State<PostCreatePage> createState() => _PostCreatePageState();
}

class _PostCreatePageState extends State<PostCreatePage> {
  final apiService = ApiService();
  final tecTitle = TextEditingController();
  final tecBody = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Uji coba dengan menggukan console utk melakukan transaksi post data
    // apiService.createPost('Title 4', 'Body 4');
    if (widget.postModel != null) {
      tecTitle.text = widget.postModel!.title!;
      tecBody.text = widget.postModel!.body!;
    }

    return Scaffold(
      appBar: AppBar(
        title:
            widget.postModel == null ? Text('Form Post') : Text('Form Update'),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: tecTitle,
                decoration: InputDecoration(
                    labelText: 'Title', hintText: 'Masukkan title'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Title masih kosong'
                    : null,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: tecBody,
                maxLines: 3,
                decoration: InputDecoration(
                    labelText: 'Body', hintText: 'Masukkan body'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Body masih kosong' : null,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      if (widget.postModel == null &&
                          formKey.currentState!.validate()) {
                        // Penyimpanan data atau post data menggunakan UI
                        await apiService.createPost(tecTitle.text.toString(),
                            tecBody.text.toString());
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Data post berhasil disimpan')));

                        // Setelah berhasil melakukan post data arahkan halaman ke halaman HomePage
                        // dengan isi data yang baru
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()),
                                (route) => false);

                      } else if (formKey.currentState!.validate()) {
                        await apiService.updatePost(
                            int.parse(widget.postModel!.id.toString()),
                            tecTitle.text.toString(),
                            tecBody.text.toString());

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Data post berhasil diubah')));

                        // Setelah berhasil melakukan put data arahkan halaman ke halaman HomePage
                        // dengan isi data yang baru
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()),
                                (route) => false);
                      }
                    },
                    child: widget.postModel == null
                        ? Text('Simpan')
                        : Text('Ubah')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
