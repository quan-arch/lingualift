import 'package:flutter/material.dart';
import 'package:lingualift/entity/todo_entity.dart';
import 'package:lingualift/widgets/exercises/exercise_a.dart';
import 'package:lingualift/widgets/exercises/exercise_b.dart';
import 'package:lingualift/widgets/exercises/exercise_c.dart';
import 'package:lingualift/widgets/todo_exercise_item.dart';

class TodoPageOne extends StatelessWidget {
  const TodoPageOne({super.key});

  @override
  Widget build(BuildContext context) {
    final list = todos.getRange(0, 4).toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return TodoExerciseItem(todoEntity: list[index], onTap: (todoEntity ) {
              if(todoEntity.character == 'A') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ExerciseAWrapperPage(
                          title: 'Single answer question')),
                );
              } else if(todoEntity.character == 'B') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ExerciseBWrapperPage(
                          title: 'Single answer question')),
                );
              } else if(todoEntity.character == 'C'){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ExerciseCWrapperWidget(
                          title: 'Single answer question')),
                );
              }
            },
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 20);
          },
          itemCount: list.length),
    );
  }

}