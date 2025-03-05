import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingualift/cubit/incomplete_sentence/incomplete_sentence_cubit.dart';
import 'package:lingualift/widgets/incomplete_sentence_body_widget.dart';

class ExerciseAWrapperPage extends StatelessWidget {
  const ExerciseAWrapperPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<IncompleteSentenceCubit>(
      create: (_) => IncompleteSentenceCubit()
        ..fetchData(collectionName: 'incomplete-sentences'),
      child: IncompleteSentenceBodyWidget(title: title),
    );
  }
}