import 'package:flutter/material.dart';
import 'package:lingualift/common/app_colors.dart';

class AppBlueButton extends StatelessWidget {
  const AppBlueButton(
      {super.key,
      required this.text,
      required this.onTap,
      required this.background,
      required this.textColor});

  final String text;
  final VoidCallback onTap;
  final Color background;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onTap.call();
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        side: BorderSide(
          color: AppColors.black,
          width: 1,
        ),
        backgroundColor: background,
        padding: EdgeInsets.all(0),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
        ),
      ),
    );
  }
}
