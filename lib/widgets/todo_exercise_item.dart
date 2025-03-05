import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingualift/common/app_colors.dart';
import 'package:lingualift/entity/todo_entity.dart';

class TodoExerciseItem extends StatelessWidget {
  const TodoExerciseItem({required this.todoEntity, required this.onTap, super.key});

  final TodoEntity todoEntity;
  final Function(TodoEntity) onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          todoEntity.character,
          style: GoogleFonts.quicksand(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.green,
            height: 1.25,
          ),
        ),
        SizedBox(width: 7),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                todoEntity.text,
                style: GoogleFonts.quicksand(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                  height: 1.25,
                ),
              ),
              GestureDetector(
                onTap: () => onTap(todoEntity),
                child: Text(
                  !todoEntity.completed ? 'Take the test' : 'Completed',
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    fontWeight: !todoEntity.completed ? FontWeight.w300 : FontWeight.bold,
                    color:
                        !todoEntity.completed ? AppColors.red : AppColors.green,
                    decoration: !todoEntity.completed
                        ? TextDecoration.underline
                        : TextDecoration.none,
                    decorationColor:
                        !todoEntity.completed ? AppColors.red : AppColors.green,
                    height: 1.25,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
