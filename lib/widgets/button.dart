// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:todo/constants/color.dart';

class CustomButton extends StatelessWidget {
  void Function()? onTap;
  CustomButton({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 90,
        height: 50,
        decoration: BoxDecoration(
            color: primary, borderRadius: BorderRadius.circular(10)),
        child: const Center(
          child: Text(
            'CREATE',
            style: TextStyle(
                color: secondary, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
