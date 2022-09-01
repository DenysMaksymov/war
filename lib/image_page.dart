import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:war/file.dart';
import 'package:war/firebase_api.dart';

class ImagePage extends StatelessWidget {
  final FirebaseFile file;
  const ImagePage({Key? key, required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(file.name),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseApi.downloadFile(file.ref);
              },
              icon: const Icon(Icons.download))
        ],
      ),
      body: Image.network(
        file.url,
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
