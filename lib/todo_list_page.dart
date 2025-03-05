import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingualift/common/app_colors.dart';
import 'package:lingualift/common/app_images.dart';
import 'package:lingualift/entity/todo_entity.dart';
import 'package:lingualift/unit_one_a.dart';
import 'package:lingualift/unit_one_b.dart';
import 'package:lingualift/widgets/todo_checked_box_item.dart';
import 'package:lingualift/widgets/todo_exercise_item.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.paperBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 79 - MediaQuery.of(context).padding.top,
                left: 159,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Unit 1',
                    style: GoogleFonts.quicksand(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1.25,
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    SizedBox(height: 68),
                    _buildCheckedBoxGroup(context),
                    SizedBox(height: 56),
                    Text('TO DO LIST', style: GoogleFonts.quicksand(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                      height: 1.25,
                    ),),
                    SizedBox(height: 62),
                    _buildPage1(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckedBoxGroup(BuildContext context) {
    return SizedBox(
      height: 47,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return TodoCheckedBoxItem(todoEntity: todos[index],);
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(width: 18);
            },
            itemCount: todos.length),
      ),
    );
  }

  Widget _buildPage1(BuildContext context) {
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
                      builder: (context) => const UnitOneAWrapperPage(
                          title: 'Single answer question')),
                );
              } else if(todoEntity.character == 'B') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UnitOneBWrapperPage(
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
