import 'package:flutter/material.dart';
import 'package:task_app/core/constants/app_colors.dart';

import '../extension/screen_utils.dart';

class CustomIconButton extends StatelessWidget {
  final String textButton;
  final Color? textColor;
  final Color? buttomColor;
  final void Function() onPressed;
  const CustomIconButton({
    super.key,
    required this.textButton,
    required this.onPressed,
    this.textColor = AppColors.backgroundColor,
    this.buttomColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Colors.green),
        ),
        elevation: 5,
        backgroundColor: buttomColor,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: Alignment.center,
        minimumSize: Size(context.width * 0.7, 60),
      ),
      onPressed: onPressed,
      child: Text(
        textButton,
        style: TextStyle(
          fontSize: 20,
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
