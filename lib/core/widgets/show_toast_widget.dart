import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:task_app/core/constants/app_colors.dart';

import '../extension/screen_utils.dart';

void customShowTost(
    {required BuildContext context,
    required String message,
    Color color = AppColors.accentGreen}) {
  showToast(
    message,
    context: context,
    backgroundColor: color,
    textStyle: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    animation: StyledToastAnimation.slideFromBottom,
    reverseAnimation: StyledToastAnimation.fade,
    position: context.isDesktop
        ? StyledToastPosition.top
        : StyledToastPosition.bottom,
  );
}
