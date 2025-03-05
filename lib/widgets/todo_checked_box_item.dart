import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingualift/common/app_colors.dart';
import 'package:lingualift/common/app_images.dart';
import 'package:lingualift/entity/todo_entity.dart';

class TodoCheckedBoxItem extends StatelessWidget {
  const TodoCheckedBoxItem({required this.todoEntity, super.key});
  final TodoEntity todoEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          todoEntity.completed
              ? AppImages.checkedBox
              : AppImages.uncheckedBox,
          height: 20,
          width: 20,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 2),
        Text(
          todoEntity.character,
          style: GoogleFonts.quicksand(
            fontSize: 16,
            fontWeight: todoEntity.completed
                ? FontWeight.bold
                : FontWeight.w300,
            color: Colors.black,
          ),
        )
      ],
    );
  }

}