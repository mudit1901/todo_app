import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/screens/home_Screen.dart';
import 'package:todo/service/todo_service.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final TodoService todoService = TodoService();
    return MaterialApp(
      title: 'To Do App',
      home: FutureBuilder(
        future: todoService.getAllTodos(),
        builder: (context, AsyncSnapshot<List<Task>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const HomeScreen();
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
