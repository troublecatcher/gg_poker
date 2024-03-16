import 'package:flutter/material.dart';
import 'package:gg_poker/theme/const.dart';

class DialogFrame extends StatelessWidget {
  final Widget child;

  const DialogFrame({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors.reversed.toList(),
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: borderRadius,
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: borderRadius,
        ),
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: child,
        ),
      ),
    );
  }
}
