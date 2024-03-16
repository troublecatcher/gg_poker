import 'package:flutter/material.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';
import 'package:gg_poker/theme/const.dart';

class HandMessageWidget extends StatelessWidget {
  final String data;

  const HandMessageWidget(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return ShakeWidget(
      duration: const Duration(seconds: 3),
      autoPlay: true,
      shakeConstant: ShakeDefaultConstant1(),
      child: Container(
        padding: padding,
        decoration: const BoxDecoration(
          color: greyColor,
          borderRadius: borderRadius,
        ),
        child: Text(data),
      ),
    );
  }
}
