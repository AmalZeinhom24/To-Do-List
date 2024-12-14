import 'package:flutter/material.dart';

class EditItems extends StatelessWidget {
  final Widget widget;
  final String title;

  const EditItems({super.key, required this.widget, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Text(title,
                style: TextStyle(fontSize: 18, color: Colors.grey))),
        SizedBox(height: 40),
        Expanded(
          flex: 3,
            child: widget,
        ),
      ],
    );
  }
}