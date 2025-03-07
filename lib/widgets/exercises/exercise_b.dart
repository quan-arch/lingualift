import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingualift/cubit/incomplete_sentence/incomplete_sentence_cubit.dart';
import 'package:lingualift/widgets/incomplete/sentence/incomplete_sentence_body_widget.dart';

class ExerciseBWrapperPage extends StatelessWidget {
  const ExerciseBWrapperPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<IncompleteSentenceCubit>(
      create: (_) => IncompleteSentenceCubit()
        ..fetchData(collectionName: 'incomplete-sentence-1'),
      child: IncompleteSentenceBodyWidget(title: title),
    );
  }
}