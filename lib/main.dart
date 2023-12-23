import 'package:dockIt/components/Tasks.dart';
import 'package:dockIt/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:dockIt/components/Home.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('tasks');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => HomePage(),
        MyRoutes.tasksRoute: (context) => TasksPage(),
      },
    );
  }
}
