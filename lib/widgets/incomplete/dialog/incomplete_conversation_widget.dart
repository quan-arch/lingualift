import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingualift/common/app_colors.dart';
import 'package:lingualift/common/app_images.dart';
import 'package:lingualift/cubit/incomplete_word/incomplete_word_cubit.dart';
import 'package:lingualift/entity/word_entity.dart';
import 'package:lingualift/widgets/incomplete/dialog/incomplete_conversation_item.dart';
import 'package:lingualift/widgets/incomplete/dialog/incomplete_conversion_dialog.dart';

class IncompleteConversationWidget extends StatefulWidget {
  final List<WordEntity>? listQuestion;
  final int? currentIndex;
  final String? question;
  final Function() onNextPage;
  final int totalPage;

  const IncompleteConversationWidget({
    required this.listQuestion,
    required this.onNextPage,
    this.currentIndex,
    this.question,
    this.totalPage = 0,
    super.key,
  });

  @override
  State<IncompleteConversationWidget> createState() =>
      _IncompleteConversationState();
}

class _IncompleteConversationState extends State<IncompleteConversationWidget> {
  @override
  Widget build(BuildContext context) {
    return _buildBodyWidget(context);
  }

  Widget _buildBodyWidget(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: (WidgetsBinding.instance.window.viewInsets.bottom > 0.0)
                ? MediaQuery.of(context).size.width * 24 / 430
                : (MediaQuery.of(context).size.width * 145 / 430) - 100),
        WidgetsBinding.instance.window.viewInsets.bottom > 0.0
            ? _buildSmallCountdownTimer(context)
            : _buildCountdownTimer(context),
        SizedBox(
          height: (WidgetsBinding.instance.window.viewInsets.bottom > 0.0)
              ? MediaQuery.of(context).size.width * 10 / 430
              : MediaQuery.of(context).size.width * 39 / 430,
        ),
        Expanded(child: _buildPageView(context)),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: _buildPageIndicator(),
        ),
      ],
    );
  }

  Widget _buildPageView(BuildContext context) {
    if (widget.totalPage == 0) return SizedBox.shrink();
    return PageView.builder(
      onPageChanged: (int page) {
        setState(() {
          _selectedIndex = page;
        });
      },
      itemCount: widget.totalPage,
      itemBuilder: (BuildContext context, int index) {
        return IncompleteConversationItem(
            listQuestion: widget.listQuestion.filterByIndex(index + 1) ?? [],
            question: widget.question);
      },
    );
  }

  int _selectedIndex = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < 3; i++) {
      list.add(i == _selectedIndex ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return SizedBox(
      height: 10,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        height: isActive ? 10 : 8.0,
        width: isActive ? 12 : 8.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? AppColors.blue : AppColors.grey,
        ),
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
              color: AppColors.red),
        ),
      ],
    );
  }

  Widget _buildSmallCountdownTimer(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          width: 40,
          height: 40,
          AppImages.countdownTimer,
          fit: BoxFit.fill,
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 7 / 430),
        Text(
          '00:09s',
          style: GoogleFonts.quicksand(
              fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.red),
        ),
      ],
    );
  }
}
