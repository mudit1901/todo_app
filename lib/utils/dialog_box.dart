import 'package:flutter/material.dart';
import 'package:todo_app/utils/buttons.dart';

class DialogBox extends StatelessWidget {
  final inputcontroller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox(
      {super.key,
      required this.inputcontroller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey.shade200,
      // ignore: sized_box_for_whitespace
      content: Container(
        height: 120,
        child: Column(
          children: [
            TextField(
              controller: inputcontroller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Add New Task"),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Save Button
                MyButton(
                  text: 'Save',
                  onPressed: onSave,
                  color: Colors.green,
                ),
                //Cancel Button
                MyButton(
                  text: 'Cancel',
                  onPressed: onCancel,
                  color: Colors.red.shade300,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
