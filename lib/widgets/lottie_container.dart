import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieContainer extends StatelessWidget {
  const LottieContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 70,
      child: Lottie.asset(
        'assets/loader.json',
      ),
    );
  }
}
