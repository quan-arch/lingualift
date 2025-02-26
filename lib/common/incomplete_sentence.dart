import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lingualift/common/app_colors.dart';
import 'package:lingualift/common/app_images.dart';

class IncompleteSentencePage extends StatefulWidget {
  const IncompleteSentencePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<IncompleteSentencePage> createState() => _IncompleteSentencePageState();
}

class _IncompleteSentencePageState extends State<IncompleteSentencePage> {
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
          SafeArea(child: _buildBodyWidget(context)),
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

  Widget _buildBodyWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildAppbar(context),
          const SizedBox(height: 93),
          _buildCountdownTimer(context),
          const SizedBox(height: 58),
          _buildQnA(context)
        ],
      ),
    );
  }

  Widget _buildCountdownTimer(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          width: 40,
          height: 40,
          AppImages.countdownTimer,
          fit: BoxFit.fill,
        ),
        const SizedBox(height: 6),
        Text(
          '00:09s',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.red),
        ),
      ],
    );
  }

  Widget _buildQnA(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 43),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildQuestion(context,
              'A. Write the verb in brackets in the correct form, present simple or present continuous, in each gap.'),
          const SizedBox(height: 37),
          _buildAnswer(context),
        ],
      ),
    );
  }

  Widget _buildQuestion(BuildContext context, String text) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
    );
  }

  TextEditingController numberCtrl = TextEditingController();

  Widget _buildAnswer(BuildContext context) {
    List<InlineSpan> spans = [];
    for (var sentence in mock.first.sentences) {
      final listInlineWidget = fromSentenceToWidget(sentence);
      spans.addAll(listInlineWidget);
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('1', style: TextStyle(fontSize: 16, color: Colors.black)),
        SizedBox(width: 10),
        Expanded(
          child: Text.rich(
            textAlign: TextAlign.start,
            TextSpan(
              children: spans,
            ),
          ),
        ),
      ],
    );
  }

  List<InlineSpan> _buildSuggestion(BuildContext context, String text) {
    return [
      TextSpan(
        text: ' (',
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
      TextSpan(
        text: text,
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      TextSpan(
        text: ') ',
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
    ];
  }

  Widget _buildAnswerBox(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 20,
      child: Stack(
        children: [
          Positioned(
            bottom: 8,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 150,
                height: 20,
                child: TextFormField(
                  cursorHeight: 16,
                  autocorrect: false,
                  enableSuggestions: false,
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    decorationThickness: 0,
                    fontSize: 16,
                    color: AppColors.blue,
                  ),
                  maxLines: 1,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                '.........................................................',
                style: TextStyle(fontSize: 8),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<InlineSpan> fromSentenceToWidget(Sentence sentence) {
    switch (sentence.type) {
      case 'word':
        return [
          TextSpan(
            text: sentence.content,
            style: TextStyle(fontSize: 16, color: Colors.black),
          )
        ];
      case 'answer':
        return [
          WidgetSpan(
            child: _buildAnswerBox(context),
          )
        ];
      case 'suggestion':
        return _buildSuggestion(context, sentence.content);
      default:
        return [
          TextSpan(
            text: sentence.content,
            style: TextStyle(fontSize: 16, color: Colors.black),
          )
        ];
    }
  }

  List<IncompleteSentenceQuestion> mock = [
    IncompleteSentenceQuestion(
        question:
            'A. Write the verb in brackets in the correct form, present simple or present continuous, in each gap.',
        type: 'incomplete_sentence',
        sentences: [
          Sentence(content: 'My brother', type: 'word', key: ''),
          Sentence(content: '', type: 'answer', key: '1a'),
          Sentence(content: 'do', type: 'suggestion', key: '1a'),
          Sentence(
              content: 'degree at university so I', type: 'word', key: '1a'),
          Sentence(content: '', type: 'answer', key: '1b'),
          Sentence(content: 'see', type: 'suggestion', key: '1b'),
          Sentence(
              content: 'him very often, unfortunately', type: 'word', key: ''),
        ],
        correctAnswer: [])
  ];
}

@immutable
class IncompleteSentenceQuestion {
  const IncompleteSentenceQuestion({
    required this.question,
    required this.type,
    required this.sentences,
    required this.correctAnswer,
  });

  IncompleteSentenceQuestion.fromJson(Map<String, Object?> json)
      : this(
          sentences: (json['sentences']! as List<Sentence>),
          question: json['question']! as String,
          type: json['type']! as String,
          correctAnswer: json['correct_answer']! as List<CorrectAnswer>,
        );

  final String question;
  final String type;
  final List<Sentence> sentences;
  final List<CorrectAnswer> correctAnswer;

  Map<String, Object?> toJson() {
    return {
      'question': question,
      'type': type,
      'sentences': sentences,
      'correct_answer': correctAnswer
    };
  }
}

class Sentence {
  final String content;
  final String type;
  final String key;

  const Sentence({
    required this.content,
    required this.type,
    required this.key,
  });

  Sentence.fromJson(Map<String, Object?> json)
      : this(
          content: (json['content']! as String),
          type: json['type']! as String,
          key: json['key']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'content': content,
      'type': type,
      'key': key,
    };
  }
}

class CorrectAnswer {
  final String answer;
  final String key;

  const CorrectAnswer({
    required this.answer,
    required this.key,
  });

  CorrectAnswer.fromJson(Map<String, Object?> json)
      : this(
          answer: (json['answer']! as String),
          key: json['key']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'answer': answer,
      'key': key,
    };
  }
}
