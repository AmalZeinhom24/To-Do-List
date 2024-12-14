import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:todo/screens/settings/widgets/forward_button.dart';

class SettingsItems extends StatelessWidget {
  final String title;
  final Color bgColor;
  final Color iconColor;
  final IconData icon;
  final String? value;
  final VoidCallback? onTap;

  SettingsItems(
      {super.key,
      required this.title,
      required this.bgColor,
      required this.iconColor,
      required this.icon,
      this.value,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(shape: BoxShape.circle, color: bgColor),
              child: Icon(
                icon,
                color: iconColor,
              ),
            ),
            SizedBox(width: 20),
            Text(title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            Spacer(),
            value != null
                ? Text(value!,
                    style: TextStyle(fontSize: 16, color: Colors.grey))
                : SizedBox(),
            SizedBox(width: 20),
            ForwardButton(onTap: onTap ?? () {})
          ],
        ),
      ),
    );
  }
}
