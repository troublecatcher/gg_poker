import 'package:flutter/material.dart';
import 'package:gg_poker/theme/const.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  const CustomContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}
