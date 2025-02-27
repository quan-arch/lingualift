import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lingualift/common/app_colors.dart';
import 'package:lingualift/common/app_images.dart';
import 'package:lingualift/component/app_blue_button.dart';

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
          _hasAnyAnswerIncorrect() ? _buildErrorMessage(context, mock.first) : const SizedBox.shrink(),
          const SizedBox(height: 44),
          AppBlueButton(
            text: 'Check the answer',
            textColor: Colors.white,
            background: AppColors.blue,
            onTap: () {
              checkAnswer();
            },
          )
        ],
      ),
    );
  }

  Widget _buildQuestion(BuildContext context, String text) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.black),
      textAlign: TextAlign.center,
    );
  }

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

  Widget _buildAnswerBox(BuildContext context, Sentence sentence) {
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
                    color: _isThisAnswerCorrect(sentence.key) ? AppColors.green : AppColors.blue,
                    fontWeight: _isThisAnswerCorrect(sentence.key) ? FontWeight.bold : FontWeight.w300
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

  Widget _buildErrorMessage(
      BuildContext context, IncompleteSentenceQuestion question) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Text(
          'Sorry, not quite...',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: 8),
        ...fromAnswerBoxToWidget(mock.first.sentences),
      ],
    );
  }

  Widget _buildCorrectedAnswer({
    required BuildContext context,
    required Sentence sentence,
  }) {
    final yourAnswer =
        _myAnswers.where((answer) => answer.key == sentence.key).first.answer;

    final correctAnswer = sentence.correctAnswer ?? '';

    if (yourAnswer == correctAnswer) {
      return SizedBox.shrink();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          yourAnswer,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: AppColors.black,
            decoration: TextDecoration.lineThrough,
          ),
        ),
        const SizedBox(width: 5),
        Image.asset(
          width: 16,
          height: 16,
          AppImages.arrowRight,
          fit: BoxFit.fill,
        ),
        const SizedBox(width: 5),
        Text(
          sentence.correctAnswer ?? '',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: AppColors.red,
          ),
        ),
      ],
    );
  }

  List<Widget> fromAnswerBoxToWidget(List<Sentence> sentences) {
    final results =
        sentences.where((sentence) => sentence.type == 'answer').toList();
    return results
        .map(
          (result) => _buildCorrectedAnswer(
            context: context,
            sentence: result,
          ),
        )
        .toList();
  }

  List<InlineSpan> fromSentenceToWidget(Sentence sentence) {
    switch (sentence.type) {
      case 'word':
        return [
          TextSpan(
            text: sentence.content,
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w300),
          )
        ];
      case 'answer':
        return [
          WidgetSpan(
            child: _buildAnswerBox(context, sentence),
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

  void checkAnswer() {
    FocusManager.instance.primaryFocus?.unfocus();
    List<Sentence> correctAnswers = mock.first.sentences
        .where((answer) => answer.type == 'answer')
        .toList();
    for(int i = 0; i < _myAnswers.length; i++) {
      final key = _myAnswers[i].key;
      final answer = _myAnswers[i].answer;
      final index = correctAnswers.indexWhere((c) => c.correctAnswer == answer && c.key == key);
      if(index == -1) {
        setState(() {
          _myAnswers[i] = _myAnswers[i].copyWith(status: AnswerStatus.incorrect);
        });
      } else {
        setState(() {
          _myAnswers[i] = _myAnswers[i].copyWith(status: AnswerStatus.correct);
        });
      }
    }
  }

  bool _hasAnyAnswerIncorrect(){
    final index = _myAnswers.indexWhere((c) => c.status == AnswerStatus.incorrect);
    return index != -1;
  }

  Answer? _findAnswerByKey(String key) {
    final index = _myAnswers.indexWhere((c) => c.key == key);
    if(index == -1) return null;
    return _myAnswers[index];
  }

  bool _isThisAnswerCorrect(String key) {
    final index = _myAnswers.indexWhere((c) => c.key == key && c.status == AnswerStatus.correct);
    return index != -1;
  }

  final _myAnswers = [
    Answer(answer: 'is doing', key: '1a'),
    Answer(answer: 'don\'t see', key: '1b')
  ];

  List<IncompleteSentenceQuestion> mock = [
    IncompleteSentenceQuestion(
      question:
          'A. Write the verb in brackets in the correct form, present simple or present continuous, in each gap.',
      type: 'incomplete_sentence',
      sentences: [
        Sentence(content: 'My brother', type: 'word', key: ''),
        Sentence(
            content: '', type: 'answer', key: '1a', correctAnswer: 'is doing'),
        Sentence(content: 'do', type: 'suggestion', key: '1a'),
        Sentence(content: 'degree at university so I', type: 'word', key: '1a'),
        Sentence(
            content: '',
            type: 'answer',
            key: '1b',
            correctAnswer: 'don\'t see'),
        Sentence(content: 'see', type: 'suggestion', key: '1b'),
        Sentence(
            content: 'him very often, unfortunately', type: 'word', key: ''),
      ],
    )
  ];
}

enum AnswerStatus { waiting, correct, incorrect }

@immutable
class IncompleteSentenceQuestion {
  const IncompleteSentenceQuestion({
    required this.question,
    required this.type,
    required this.sentences,
  });

  IncompleteSentenceQuestion.fromJson(Map<String, Object?> json)
      : this(
          sentences: (json['sentences']! as List<Sentence>),
          question: json['question']! as String,
          type: json['type']! as String,
        );

  final String question;
  final String type;
  final List<Sentence> sentences;

  Map<String, Object?> toJson() {
    return {
      'question': question,
      'type': type,
      'sentences': sentences,
    };
  }
}

class Sentence {
  final String content;
  final String type;
  final String key;
  final String? correctAnswer;

  const Sentence({
    required this.content,
    required this.type,
    required this.key,
    this.correctAnswer,
  });

  Sentence.fromJson(Map<String, Object?> json)
      : this(
          content: (json['content']! as String),
          type: json['type']! as String,
          key: json['key']! as String,
          correctAnswer: json['correct_answer']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'content': content,
      'type': type,
      'key': key,
      'correct_answer': correctAnswer
    };
  }
}

class Answer {
  final String answer;
  final String key;
  final AnswerStatus status;

  const Answer({
    required this.answer,
    required this.key,
    this.status = AnswerStatus.waiting,
  });

  Answer copyWith({
    String? answer,
    String? key,
    AnswerStatus? status,
  }) {
    return Answer(
      answer: answer ?? this.answer,
      key: key ?? this.key,
      status: status ?? this.status,
    );
  }

  Answer.fromJson(Map<String, Object?> json)
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
