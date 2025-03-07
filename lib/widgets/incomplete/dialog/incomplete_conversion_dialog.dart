import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingualift/common/app_colors.dart';

class IncompleteConversationDialog extends StatelessWidget {
  const IncompleteConversationDialog({super.key, this.suggestions = mock});

  final List<String> suggestions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.green, width: 2)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Wrap(
            runSpacing: 8,
            spacing: 8,
            alignment: WrapAlignment.center,
            children: suggestions.map((e) => _buildItem(context, e)).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: GoogleFonts.quicksand(fontSize: 16, color: AppColors.black),
        ),
        SizedBox(width: 8),
        SizedBox(
            width: 5,
            height: 5,
            child: DecoratedBox(
                decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.green))),
      ],
    );
  }
}

const List<String> mock = [
  'contact',
  'do',
  'drive',
  'focus',
  'go',
  'happen',
  'have',
  'like',
  'look',
  'need',
  'say',
  'sound',
  'take',
  'think',
  'try',
  'work'
];
