import 'package:hive/hive.dart';
import 'package:todo/model/task_model.dart';

class TodoService {
  final String _boxName = "todoBox";

  Future<Box<Task>> get _box async => await Hive.openBox<Task>(_boxName);
//Add Task
  Future<void> addItem(Task task) async {
    var box = await _box;
    box.add(task);
  }

//Get Tasks
  Future<List<Task>> getAllTodos() async {
    var box = await _box;
    return box.values.toList();
  }

  //Delete Task
  Future<void> deleteTodo(int index) async {
    var box = await _box;
    await box.deleteAt(index);
  }

//Update
  Future<void> updateIsCompleted(int index, Task task) async {
    var box = await _box;
    task.isCompleted = !task.isCompleted;
    await box.putAt(index, task);
  }
}
