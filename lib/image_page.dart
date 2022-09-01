import 'dart:typed_data';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:war/file.dart';
import 'package:war/firebase_api.dart';

class ImagePage extends StatefulWidget {
  final FirebaseFile file;
  const ImagePage({Key? key, required this.file}) : super(key: key);

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  final storageRef = FirebaseStorage.instance.ref();

  void download() async {
    final islandRef = storageRef.child("models/pexels-pixabay-87651" + ".jpg");
    try {
      final Uint8List? data = await islandRef.getData();
      print(data);
    } on FirebaseException catch (e) {
      return;
    }
  }

  @override
  void initState() {
    download();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.file.name),
        actions: [
          IconButton(
              onPressed: () async {
                final data = await FirebaseApi.downloadFile(widget.file.ref);
                print(data);
              },
              icon: const Icon(Icons.download))
        ],
      ),
      body: Image.network(
        widget.file.url,
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
