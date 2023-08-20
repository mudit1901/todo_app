import 'package:flutter/material.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/utils/todo_tile.dart';
import 'package:hive/hive.dart';
import '../utils/dialog_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('myBox');

  ToDoDataBase database = ToDoDataBase();

  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      database.createInitialData();
    } else {
      database.loadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();

  //Onchecking the Box
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      database.toDoList[index][1] = !database.toDoList[index][1];
    });
    database.updateDataBase();
  }

//On Saving the Task
  void onsavedo() {
    setState(() {
      if (_controller.text.length <= 21) {
        database.toDoList.add([_controller.text, false]);
        _controller.clear();
      }
    });
    Navigator.of(context).pop();
    database.updateDataBase();
  }

//For Clicking Dialog Box on New Task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          inputcontroller: _controller,
          onSave: onsavedo,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      database.toDoList.removeAt(index);
    });
    database.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(200, 2, 42, 61),
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          "Your To do List",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 7, 43, 73),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          semanticLabel: 'Add to Your Todo',
          size: 30,
        ),
        onPressed: () => createNewTask(),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return TodoList(
            taskName: database.toDoList[index][0],
            taskCompleted: database.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            ondelete: (context) => deleteTask(index),
          );
        },
        itemCount: database.toDoList.length,
      ),
    );
  }
}
