import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:task_app/core/constants/app_strings.dart';
import 'package:task_app/core/extension/navigations.dart';

import '../../config/router/name_routs.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          AppStrings.taskLottie,
          onLoaded: (p0) {
            Future.delayed(
              const Duration(milliseconds: 1500),
              () {
                if (context.mounted) {
                  context.pushNamedAndRemoveUntil(pageRoute: NameRouts.task);
                }
              },
            );
          },
        ),
      ),
    );
  }
}
