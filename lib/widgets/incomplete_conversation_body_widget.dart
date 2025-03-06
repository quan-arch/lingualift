import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingualift/common/app_images.dart';
import 'package:lingualift/cubit/incomplete_word/incomplete_word_cubit.dart';
import 'package:lingualift/widgets/incomplete_conversation_widget.dart';

class IncompleteConversationBodyWidget extends StatefulWidget {
  const IncompleteConversationBodyWidget({super.key, required this.title});

  final String title;

  @override
  State<IncompleteConversationBodyWidget> createState() => _IncompleteConversationBodyState();
}

class _IncompleteConversationBodyState extends State<IncompleteConversationBodyWidget> {
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
                    BlocBuilder<IncompleteWordCubit, IncompleteWordState>(
                      builder: (blocContext, state) {
                        if (state.status == LoadStatus.loading) {
                          return SizedBox.shrink();
                        }
                        if (state.status == LoadStatus.failure) {
                          return Center(
                            child: Text('Failure'),
                          );
                        }
                        if (state.status == LoadStatus.success) {
                          return IncompleteConversationWidget(
                              question: state.question,
                              listQuestion: state.listQuestion,
                              currentIndex: state.currentIndex,
                              onNextPage: () {
                                context
                                    .read<IncompleteWordCubit>()
                                    .nextPage();
                              });
                        }
                        return Center(
                          child: Text('Init'),
                        );
                      },
                    )
                  ],
                ),
              ),
              Positioned(
                top: 75 - MediaQuery.of(context).padding.top,
                left: 30,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      size: 30,
                      Icons.arrow_back_ios_outlined,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// List<QuestionEntity> mock = [
// IncompleteSentenceQuestion(
//   question:
//       'A. Write the verb in brackets in the correct form, present simple or present continuous, in each gap.',
//   type: 'incomplete_sentence',
//   sentences: [
//     Sentence(content: 'My brother', type: 'word', key: ''),
//     Sentence(
//         content: '', type: 'answer', key: '1a', correctAnswer: 'is doing'),
//     Sentence(content: 'do', type: 'suggestion', key: '1a'),
//     Sentence(content: 'degree at university so I', type: 'word', key: '1a'),
//     Sentence(
//         content: '',
//         type: 'answer',
//         key: '1b',
//         correctAnswer: 'don\'t see'),
//     Sentence(content: 'see', type: 'suggestion', key: '1b'),
//     Sentence(
//         content: 'him very often, unfortunately.', type: 'word', key: ''),
//   ],
// )
// ];
}