import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingualift/common/app_colors.dart';
import 'package:lingualift/common/app_images.dart';
import 'package:lingualift/entity/todo_entity.dart';
import 'package:lingualift/new_word_page.dart';
import 'package:lingualift/widgets/exercises/exercise_a.dart';
import 'package:lingualift/widgets/exercises/exercise_b.dart';
import 'package:lingualift/widgets/todo_checked_box_item.dart';
import 'package:lingualift/widgets/todo_exercise_item.dart';
import 'package:lingualift/widgets/todos/todo_page_three.dart';
import 'package:lingualift/widgets/todos/todo_page_two.dart';

import 'widgets/todos/todo_page_one.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
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
                    Text(
                      'TO DO LIST',
                      style: GoogleFonts.quicksand(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                        height: 1.25,
                      ),
                    ),
                    SizedBox(height: 62),
                    Flexible(child: _buildPageView(context)),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: _buildPageIndicator(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const NewWordWrapperWidget(
                    title: 'New words')),
          );
        },
        label: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Icon(Icons.check_box_outlined),
            ),
            Text("Vocabulary")
          ],
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
              return TodoCheckedBoxItem(
                todoEntity: todos[index],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(width: 18);
            },
            itemCount: todos.length),
      ),
    );
  }


  Widget _buildPageView(BuildContext context) {
    return PageView.builder(
      onPageChanged: (int page) {
        setState(() {
          _selectedIndex = page;
        });
      },
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        switch(index){
          case 0:
            return TodoPageOne();
          case 1:
            return TodoPageTwo();
          case 2:
            return TodoPageThree();
          default:
            return TodoPageOne();
        }
      },
    );
  }

  int _selectedIndex = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < 3; i++) {
      list.add(i == _selectedIndex ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return SizedBox(
      height: 10,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        height: isActive ? 10 : 8.0,
        width: isActive ? 12 : 8.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? AppColors.blue : AppColors.grey,
        ),
      ),
    );
  }
}
