import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingualift/common/app_colors.dart';
import 'package:lingualift/common/app_images.dart';
import 'package:lingualift/component/app_blue_button.dart';
import 'package:lingualift/component/app_white_button.dart';
import 'package:lingualift/entity/answer_entity.dart';
import 'package:lingualift/entity/sentence_entity.dart';
import 'package:lingualift/entity/word_entity.dart';
import 'package:lingualift/widgets/incomplete/dialog/incomplete_conversion_dialog.dart';

class IncompleteConversationItem extends StatefulWidget {
  final List<WordEntity>? listQuestion;
  final String? question;

  const IncompleteConversationItem({
    required this.listQuestion,
    this.question,
    super.key,
  });

  @override
  State<IncompleteConversationItem> createState() =>
      _IncompleteConversationItemState();
}

class _IncompleteConversationItemState extends State<IncompleteConversationItem>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    List<SentenceEntity> answers = [];
    if (widget.listQuestion?.isNotEmpty ?? false) {
      for (int i = 0; i < widget.listQuestion!.length; i++) {
        answers.addAll(widget.listQuestion![i].sentences
            .where((answer) => answer.type == 'answer')
            .toList());
      }
    }

    _myAnswers = answers.map((SentenceEntity sentence) {
      return AnswerEntity(
        answer: '',
        key: sentence.key,
        status: AnswerStatus.waiting,
      );
    }).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 43),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildQuestion(context, widget.question ?? ''),
          SizedBox(height: MediaQuery.of(context).size.width * 20 / 430),
          ...widget.listQuestion!.map((e) => _buildAnswer(context, e)),
          _hasAnyAnswerIncorrect()
              ? _buildErrorMessage(context, widget.listQuestion)
              : const SizedBox.shrink(),
          SizedBox(height: MediaQuery.of(context).size.width * 20 / 430),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _isTapCheckedAnswer
                  ? /*AppWhiteButton(
                  text: 'Next question',
                  onTap: () {
                    widget.onNextPage();
                  },
                )*/
              const SizedBox.shrink()
                  : AppBlueButton(
                text: 'Check the answer',
                onTap: () {
                  checkAnswer();
                },
              ),
              const SizedBox(width: 20),
              AppWhiteButton(
                text: 'Open box',
                onTap: () {
                  showGeneralDialog(
                    context: context,
                    barrierColor: Colors.black54,
                    barrierDismissible: true,
                    barrierLabel: 'Label',
                    pageBuilder: (_, __, ___) {
                      return Container(
                        margin: EdgeInsets.only(top: 130),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Material(
                              child: IncompleteConversationDialog()),
                        ),
                      );
                    },
                    transitionBuilder: (ctx, a1, a2, child) {
                      return SlideTransition(
                          position:
                          Tween(begin: Offset(-1, 0), end: Offset(0, 0)).animate(a1),
                          child: child);
                    },
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildQuestion(BuildContext context, String text) {
    return Text(
      text,
      style: GoogleFonts.quicksand(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
          height: 1.22),
      textAlign: TextAlign.center,
    );
  }

  bool _isTapCheckedAnswer = false;

  late List<AnswerEntity> _myAnswers = [];

  bool _hasAnyAnswerIncorrect() {
    final index =
        _myAnswers.indexWhere((c) => c.status == AnswerStatus.incorrect);
    return index != -1;
  }

  bool _isThisAnswerCorrect(String key) {
    final index = _myAnswers
        .indexWhere((c) => c.key == key && c.status == AnswerStatus.correct);
    return index != -1;
  }

  bool _isThisAnswerInCorrect(String key) {
    final index = _myAnswers
        .indexWhere((c) => c.key == key && c.status == AnswerStatus.incorrect);
    return index != -1;
  }

  List<Widget> fromAnswerBoxToWidget(List<SentenceEntity> sentences) {
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

  List<InlineSpan> fromSentenceToWidget(SentenceEntity sentence) {
    switch (sentence.type) {
      case 'word':
        return [
          TextSpan(
            text: sentence.content,
            style: GoogleFonts.quicksand(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: Colors.black,
              height: 1.22,
            ),
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
            style: GoogleFonts.quicksand(
                fontSize: 16, color: AppColors.black, height: 1.25),
          )
        ];
    }
  }

  void checkAnswer() {
    setState(() {
      _isTapCheckedAnswer = true;
    });
    FocusManager.instance.primaryFocus?.unfocus();
    List<SentenceEntity> correctAnswers = [];
    if (widget.listQuestion?.isNotEmpty ?? false) {
      for (int i = 0; i < widget.listQuestion!.length; i++) {
        correctAnswers.addAll((widget.listQuestion![i].sentences)
            .where((answer) => answer.type == 'answer')
            .toList());
      }
    }
    for (int i = 0; i < _myAnswers.length; i++) {
      final key = _myAnswers[i].key;
      final answer = _myAnswers[i].answer;
      final index = correctAnswers
          .indexWhere((c) => c.correctAnswer == answer && c.key == key);
      if (index == -1) {
        setState(() {
          _myAnswers[i] =
              _myAnswers[i].copyWith(status: AnswerStatus.incorrect);
        });
      } else {
        setState(() {
          _myAnswers[i] = _myAnswers[i].copyWith(status: AnswerStatus.correct);
        });
      }
    }
  }

  void updateAnswerByKey({required String key, required String answer}) {
    final index = _myAnswers.indexWhere((c) => c.key == key);
    if (index != -1) {
      setState(() {
        _myAnswers[index] = _myAnswers[index]
            .copyWith(answer: answer, status: AnswerStatus.waiting);
      });
    }
  }

  Widget _buildAnswer(BuildContext context, WordEntity? wordEntity) {
    List<InlineSpan> spans = [];
    for (var sentence in wordEntity?.sentences ?? []) {
      final listInlineWidget = fromSentenceToWidget(sentence);
      spans.addAll(listInlineWidget);
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 70,
          child: Text(
            '${wordEntity?.sender}:',
            style: GoogleFonts.quicksand(
                fontSize: 16,
                color: AppColors.black,
                fontWeight: FontWeight.bold,
                height: 1.25),
            overflow: TextOverflow.ellipsis,
          ),
        ),
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
        style: GoogleFonts.quicksand(
          fontSize: 16,
          color: Colors.black,
          height: 1.22,
        ),
      ),
      TextSpan(
        text: text,
        style: GoogleFonts.quicksand(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          height: 1.22,
        ),
      ),
      TextSpan(
        text: ') ',
        style: GoogleFonts.quicksand(
          fontSize: 16,
          fontWeight: FontWeight.w300,
          color: Colors.black,
          height: 1.22,
        ),
      ),
    ];
  }

  Widget _buildAnswerBox(BuildContext context, SentenceEntity sentence) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1.0),
      child: SizedBox(
        width: 150,
        height: 20,
        child: Stack(
          children: [
            Positioned(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  '.........................................................',
                  style: GoogleFonts.quicksand(fontSize: 16, height: 1.25),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 150,
                child: TextFormField(
                  cursorHeight: 16,
                  autocorrect: false,
                  enableSuggestions: false,
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.center,
                  onChanged: (text) {
                    updateAnswerByKey(key: sentence.key, answer: text);
                  },
                  style: GoogleFonts.quicksand(
                    height: 1.25,
                    decoration: _isThisAnswerInCorrect(sentence.key)
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    fontSize: 16,
                    color: _isThisAnswerCorrect(sentence.key)
                        ? AppColors.green
                        : _isThisAnswerInCorrect(sentence.key)
                            ? AppColors.grey
                            : AppColors.blue,
                    fontWeight: _isThisAnswerCorrect(sentence.key)
                        ? FontWeight.bold
                        : FontWeight.w300,
                    decorationColor: _isThisAnswerInCorrect(sentence.key)
                        ? AppColors.grey
                        : AppColors.blue,
                  ),
                  maxLines: 1,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(12.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorMessage(BuildContext context, List<WordEntity>? question) {
    List<SentenceEntity> sentences = [];
    if (question?.isNotEmpty ?? false) {
      for (int i = 0; i < question!.length; i++) {
        sentences.addAll(question[i].sentences);
      }
    }

    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.width * 20 / 430),
        Text(
          'Sorry, not quite...',
          style: GoogleFonts.quicksand(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
            height: 1.22,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 20 / 430),
        ...fromAnswerBoxToWidget(sentences),
      ],
    );
  }

  Widget _buildCorrectedAnswer({
    required BuildContext context,
    required SentenceEntity sentence,
  }) {
    try {
      if (_myAnswers.isEmpty) return SizedBox.shrink();
      final yourAnswer =
          _myAnswers.where((answer) => answer.key == sentence.key).first.answer;

      final correctAnswer = sentence.correctAnswer ?? '';

      if (yourAnswer == correctAnswer) {
        return SizedBox.shrink();
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(yourAnswer.isNotEmpty ? yourAnswer : 'No answer',
              style: GoogleFonts.quicksand(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: AppColors.grey,
                height: 1.22,
                decoration: yourAnswer.isNotEmpty
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                decorationColor:
                    yourAnswer.isNotEmpty ? AppColors.grey : AppColors.blue,
              )),
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
            style: GoogleFonts.quicksand(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: AppColors.red,
              height: 1.22,
            ),
          ),
        ],
      );
    } on Exception catch (e) {
      print(e.toString());
      return SizedBox.shrink();
    }
  }

  @override
  bool get wantKeepAlive => true;
}
