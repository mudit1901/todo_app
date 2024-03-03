import 'package:flutter/material.dart';
import 'package:todo/constants/color.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/service/todo_service.dart';
import 'package:todo/widgets/button.dart';
import 'package:todo/widgets/text_field.dart';
import 'package:todo/widgets/toast.dart';

class custom_dialog extends StatefulWidget {
  @override
  State<custom_dialog> createState() => _custom_dialogState();
}

class _custom_dialogState extends State<custom_dialog> {
  final datecontroller = TextEditingController();

  final timecontroller = TextEditingController();

  final taskcontroller = TextEditingController();
  TodoService _todoService = TodoService();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Dialog(
      backgroundColor: secondary,
      child: SizedBox(
        height: height * 0.6,
        width: width * 0.8,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'New Task',
                  style: TextStyle(
                      color: primary,
                      fontWeight: FontWeight.w500,
                      fontSize: 23),
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'What is to be Done?',
                  style: TextStyle(color: primary, fontSize: 16),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text_Field(
                    hint_text: 'Enter a Task',
                    textEditingController: taskcontroller,
                  )),
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Due Date and Time',
                  style: TextStyle(color: primary, fontSize: 15),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text_Field(
                    hint_text: 'Pick a Date',
                    textEditingController: datecontroller,
                    icon: (Icons.calendar_month),
                    readOnly: true,
                    onTap: () async {
                      DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate:
                              DateTime.now().subtract(const Duration(days: 0)),
                          lastDate: DateTime(2026));
                      if (date != null) {
                        String dateSlug =
                            "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year.toString()}";
                        datecontroller.text = dateSlug;
                      }
                    },
                  )),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text_Field(
                    hint_text: 'Pick a Time',
                    textEditingController: timecontroller,
                    icon: (Icons.timer),
                    readOnly: true,
                    onTap: () async {
                      TimeOfDay? time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (time != null) {
                        timecontroller.text = time.format(
                            context); // Update the text field with selected time
                      }
                    },
                  )),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: CustomButton(
                  onTap: () async {
                    if (taskcontroller.text.length <= 19 &&
                        taskcontroller.text.isNotEmpty &&
                        datecontroller.text.isNotEmpty &&
                        timecontroller.text.isNotEmpty) {
                      var todo = Task(false,
                          taskName: taskcontroller.text,
                          date: datecontroller.text,
                          time: timecontroller.text);

                      await _todoService.addItem(todo);
                      Navigator.pop(context);
                    } else if (taskcontroller.text.isEmpty ||
                        datecontroller.text.isEmpty ||
                        timecontroller.text.isEmpty) {
                      Utils().toastmessage('Please fill all the Field');
                    } else if (taskcontroller.text.length > 19) {
                      Utils().toastmessage('Your Task Name is too Long');
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
