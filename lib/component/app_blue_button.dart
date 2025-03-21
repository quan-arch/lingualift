import 'package:flutter/material.dart';
import 'package:lingualift/common/app_colors.dart';
import 'package:lingualift/component/app_button.dart';

class AppBlueButton extends AppButton {
  const AppBlueButton({
    super.key,
    required super.text,
    required super.onTap,
  }) : super(background: AppColors.blue, textColor: Colors.white);
}
