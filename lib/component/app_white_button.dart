import 'package:flutter/material.dart';
import 'package:lingualift/common/app_colors.dart';
import 'package:lingualift/component/app_button.dart';

class AppWhiteButton extends AppButton {
  const AppWhiteButton({
    super.key,
    required super.text,
    required super.onTap,
  }) : super(background: Colors.white, textColor: AppColors.black);
}
