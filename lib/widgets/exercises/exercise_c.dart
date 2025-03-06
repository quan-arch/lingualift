import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingualift/cubit/incomplete_word/incomplete_word_cubit.dart';
import 'package:lingualift/widgets/incomplete_conversation_body_widget.dart';

class ExerciseCWrapperWidget extends StatelessWidget {
  const ExerciseCWrapperWidget({super.key, required this.title});

  final String title;
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider<IncompleteWordCubit>(
      create: (_) => IncompleteWordCubit()
        ..fetchData(),
      child: IncompleteConversationBodyWidget(title: title),
    );
  }

}