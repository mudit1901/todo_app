import 'package:hive/hive.dart';
part 'task_model.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String taskName;
  @HiveField(1)
  String date;
  @HiveField(2)
  String time;
  @HiveField(3, defaultValue: false)
  bool isCompleted;

  Task(
    this.isCompleted, {
    required this.taskName,
    required this.date,
    required this.time,
  });
}
