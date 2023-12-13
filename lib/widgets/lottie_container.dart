import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieContainer extends StatelessWidget {
  const LottieContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 50,
      child: Lottie.asset(
        'assets/loader.json',
      ),
    );
  }
}
