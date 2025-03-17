import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingualift/common/app_colors.dart';
import 'package:lingualift/common/app_images.dart';
import 'package:lingualift/component/app_blue_button.dart';
import 'package:lingualift/component/app_white_button.dart';
import 'package:lingualift/cubit/new_word/new_word_cubit.dart';
import 'package:lingualift/entity/answer_entity.dart';
import 'package:lingualift/entity/new_word_entity.dart';
import 'package:lingualift/new_word_page.dart';

class Unit2NewWordWrapperWidget extends NewWordWrapperWidget {
  const Unit2NewWordWrapperWidget({super.key, required super.title});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewWordCubit>(
      create: (_) => NewWordCubit()..fetchUnit2Data(),
      child: BlocBuilder<NewWordCubit, NewWordState>(
        builder: (blocContext, state) {
          if (state.status == LoadStatus.loading) {
            return SizedBox.shrink();
          }
          if (state.status == LoadStatus.failure) {
            return buildScaffold(
              context: context,
              child: Center(
                child: Text('Failure'),
              ),
            );
          }
          if (state.status == LoadStatus.success) {
            return NewWordWidget(list: state.listNewWord,);
          }
          return Center(
            child: buildScaffold(context: context, child: Text('Init')),
          );
        },
      ),
    );
  }
}