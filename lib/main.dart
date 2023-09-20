
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:photo_notes_fresh_start_1/PhotoNote.dart';
import 'package:photo_notes_fresh_start_1/project.dart';

import 'main_page.dart';

void main() async{
  await Hive.initFlutter(); //initializing hive


  Hive.registerAdapter<Project>(ProjectAdapter()); //registering adapter for hive
  Hive.registerAdapter<PhotoNote>(PhotoNoteAdapter());



  await Hive.openBox('mybox');//opening box

  Project.loadProjects();



  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.blue));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme:  ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}