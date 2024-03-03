import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/constants/color.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/service/todo_service.dart';
import 'package:todo/widgets/custom_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TodoService _todoService = TodoService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: const Text(
          'Todo Plus',
          style: TextStyle(
              color: secondary, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Task>('todoBox').listenable(),
        builder: (context, Box<Task> box, child) {
          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              var todo = box.getAt(index);
              return ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                leading: Checkbox(
                  checkColor: Colors.green.shade500,
                  activeColor: secondary,
                  value: todo!.isCompleted,
                  onChanged: (value) {
                    _todoService.updateIsCompleted(index, todo);
                  },
                  shape: const CircleBorder(),
                ),
                title: Text(
                  todo.taskName,
                  style: const TextStyle(
                      color: secondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 22),
                ),
                subtitle: Text(
                  "${todo.date},${todo.time}",
                  style: const TextStyle(color: Colors.blue, fontSize: 18),
                ),
                trailing: InkWell(
                  onTap: () {
                    _todoService.deleteTodo(index);
                  },
                  child: const Icon(
                    Icons.delete,
                    size: 30,
                    color: secondary,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondary,
        child: const Icon(
          Icons.add,
          size: 30,
          color: primary,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return custom_dialog();
            },
          );
        },
      ),
    );
  }
}
