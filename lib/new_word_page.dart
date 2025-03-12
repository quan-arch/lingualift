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
import 'package:lingualift/entity/word_entity.dart';

class NewWordWrapperWidget extends StatelessWidget {
  const NewWordWrapperWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewWordCubit>(
      create: (_) => NewWordCubit()..fetchData(),
      child: BlocBuilder<NewWordCubit, NewWordState>(
        builder: (blocContext, state) {
          if (state.status == LoadStatus.loading) {
            return SizedBox.shrink();
          }
          if (state.status == LoadStatus.failure) {
            return _buildScaffold(
              context: context,
              child: Center(
                child: Text('Failure'),
              ),
            );
          }
          if (state.status == LoadStatus.success) {
            return NewWordWidget(list: state.listNewWord ?? [],);
          }
          return Center(
            child: _buildScaffold(context: context, child: Text('Init')),
          );
        },
      ),
    );
  }

  Widget _buildScaffold({required BuildContext context, required Widget child}) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
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
                    'New words',
                    style: GoogleFonts.quicksand(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1.25,
                    ),
                  ),
                ),
              ),
              child,
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
}

class NewWordWidget extends StatefulWidget {
  const NewWordWidget({required this.list, super.key});
  final List<NewWordEntity> list;

  @override
  State<NewWordWidget> createState() => _NewWordPageState();
}

class _NewWordPageState extends State<NewWordWidget> {

  @override
  void initState() {
    _myAnswers = widget.list.map((NewWordEntity newWord) {
      return AnswerEntity(
        answer: '',
        key: newWord.word,
        status: AnswerStatus.waiting,
      );
    }).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
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
                    'New words',
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
                    Expanded(
                      child: _buildBodyWidget(context,
                          list: widget.list),
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

  Widget _buildBodyWidget(BuildContext context,
      {required List<NewWordEntity> list}) {
    if (list.isEmpty) return const SizedBox.shrink();
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
              height: (MediaQuery.of(context).size.width * 188 / 430) - 100),
          _buildCountdownTimer(context),
          SizedBox(height: MediaQuery.of(context).size.width * 80 / 430),
          _buildQnA(context, list: list),
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
        SizedBox(height: MediaQuery.of(context).size.width * 7 / 430),
        Text(
          '00:09s',
          style: GoogleFonts.quicksand(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.red,
              height: 1.25),
        ),
      ],
    );
  }

  Widget _buildQnA(BuildContext context, {required List<NewWordEntity> list}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 43),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildQuestion(context, 'A. Complete the word meaning in Vietnamese'),
          SizedBox(height: MediaQuery.of(context).size.width * 20 / 430),
          ...list
              .asMap()
              .map((i, e) =>
                  MapEntry(i, _buildAnswer(context, index: i, newWord: e)))
              .values,
          _hasAnyAnswerIncorrect()
              ? _buildErrorMessage(context, list)
              : const SizedBox.shrink(),
          SizedBox(height: MediaQuery.of(context).size.width * 20 / 430),
          _isTapCheckedAnswer
              ? AppWhiteButton(
            text: 'Next question',
            onTap: () {
              //widget.onNextPage();
            },
          )
              : AppBlueButton(
            text: 'Check the answer',
            onTap: () {
              checkAnswer(list);
            },
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

  Widget _buildAnswer(BuildContext context,
      {required int index, required NewWordEntity newWord}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${index + 1}.',
            style: GoogleFonts.quicksand(
              fontSize: 16,
              color: AppColors.black,
              fontWeight: FontWeight.bold,
              height: 1.25,
            )),
        SizedBox(width: 10),
        Expanded(
          child: Text.rich(
            textAlign: TextAlign.start,
            TextSpan(
              children: [
                TextSpan(
                  text: '${newWord.word} =',
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1.22,
                  ),
                ),
                WidgetSpan(
                  child: const SizedBox(width: 10),
                ),
                WidgetSpan(
                  child: _buildAnswerBox(context, newWord),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnswerBox(BuildContext context, NewWordEntity newWord) {
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
                    // updateAnswerByKey(key: sentence.key, answer: text);
                  },
                  style: GoogleFonts.quicksand(
                    height: 1.25,
                    decoration: /*_isThisAnswerInCorrect(sentence.key)
                        ? TextDecoration.lineThrough
                        : */
                        TextDecoration.none,
                    fontSize: 16,
                    color: /*_isThisAnswerCorrect(sentence.key)
                        ? AppColors.green
                        : _isThisAnswerInCorrect(sentence.key)
                        ? AppColors.grey
                        : */
                        AppColors.blue,
                    fontWeight: /*_isThisAnswerCorrect(sentence.key)
                        ? FontWeight.bold
                        : */
                        FontWeight.w300,
                    decorationColor: /*_isThisAnswerInCorrect(sentence.key) ? AppColors.grey: */
                        AppColors.blue,
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

  void checkAnswer(List<NewWordEntity> list) {
    setState(() {
      _isTapCheckedAnswer = true;
    });
    FocusManager.instance.primaryFocus?.unfocus();
    for (int i = 0; i < _myAnswers.length; i++) {
      final key = _myAnswers[i].key;
      final answer = _myAnswers[i].answer;
      final index = list
          .indexWhere((c) => c.word == key && c.mean == answer);
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

  Widget _buildErrorMessage(BuildContext context, List<NewWordEntity>? list) {
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
        ...fromAnswerBoxToWidget(list ?? []),
      ],
    );
  }

  List<Widget> fromAnswerBoxToWidget(List<NewWordEntity> list) {
    return list
        .map(
          (result) =>
          _buildCorrectedAnswer(
            context: context,
            newWord: result,
          ),
    )
        .toList();
  }

  Widget _buildCorrectedAnswer({
    required BuildContext context,
    required NewWordEntity newWord,
  }) {
    try {
      if (_myAnswers.isEmpty) return SizedBox.shrink();
      final yourAnswer =
          _myAnswers.where((answer) => answer.key == newWord.word).first.answer;

      final correctAnswer = newWord.mean ?? '';

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
                decorationColor: yourAnswer.isNotEmpty ? AppColors.grey: AppColors.blue,
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
            newWord.mean ?? '',
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

  bool _isTapCheckedAnswer = false;
  late List<AnswerEntity> _myAnswers = [];
}
