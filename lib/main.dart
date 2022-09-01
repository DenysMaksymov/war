import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:war/firebase_api.dart';
import 'package:war/image_page.dart';

import 'file.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<FirebaseFile>> futureFile;
  @override
  void initState() {
    super.initState();
    futureFile = FirebaseApi.listAll('models/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<FirebaseFile>>(
        future: futureFile,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text('error'),
                );
              } else {
                final files = snapshot.data!;
                return ListView.builder(
                    itemCount: files.length,
                    itemBuilder: (context, index) {
                      final file = files[index];
                      return buildFile(context, file);
                    });
              }
          }
        },
      ),
    );
  }
}

Widget buildFile(BuildContext context, FirebaseFile file) => ListTile(
    leading: Image.network(
      file.url,
      width: 100,
      height: 100,
    ),
    title: Text(file.name),
    onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
              builder: (BuildContext context) => ImagePage(file: file)),
        ));
