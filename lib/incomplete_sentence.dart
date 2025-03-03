import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingualift/common/app_images.dart';
import 'package:lingualift/cubit/incomplete_sentence/incomplete_sentence_cubit.dart';
import 'package:lingualift/entity/question_entity.dart';
import 'package:lingualift/widgets/incomplete_sentence_widget.dart';

class IncompleteSentenceWrapperPage extends StatelessWidget {
  const IncompleteSentenceWrapperPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<IncompleteSentenceCubit>(
      create: (_) => IncompleteSentenceCubit()..fetchData(),
      child: IncompleteSentencePage(title: title),
    );
  }
}

class IncompleteSentencePage extends StatefulWidget {
  const IncompleteSentencePage({super.key, required this.title});

  final String title;

  @override
  State<IncompleteSentencePage> createState() => _IncompleteSentencePageState();
}

class _IncompleteSentencePageState extends State<IncompleteSentencePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // listenInvitedMembers((questions) {
      //   setState(() {
      //     mock = List<QuestionEntity>.from(questions);
      //     final answers = mock[currentIndex]
      //         .sentences
      //         .where((answer) => answer.type == 'answer')
      //         .toList();
      //     final inits = answers.map((SentenceEntity sentence) {
      //       return AnswerEntity(
      //         answer: '',
      //         key: sentence.key,
      //         status: AnswerStatus.waiting,
      //       );
      //     }).toList();
      //   });
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                width: 215,
                height: 264,
                AppImages.bannerTopRight,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset(
                width: 225,
                height: 306,
                AppImages.bannerBottomLeft,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                _buildAppbar(context),
                BlocBuilder<IncompleteSentenceCubit, IncompleteSentenceState>(
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
                      return IncompleteSentenceWidget(
                          listQuestion: state.listQuestion,
                          currentIndex: state.currentIndex,
                          onNextPage: () {
                            context.read<IncompleteSentenceCubit>().nextPage();
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
        ],
      ),
    );
  }

  Widget _buildAppbar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 49),
      child: Stack(
        children: [
          Positioned(
            left: 20,
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
          Positioned(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Unit 1 - Grammar',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<QuestionEntity> mock = [
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
  ];
}
