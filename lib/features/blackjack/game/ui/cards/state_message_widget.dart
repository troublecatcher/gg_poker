import 'package:flutter/material.dart';
import 'package:gg_poker/theme/const.dart';

class StateMessageWidget extends StatelessWidget {
  final String data;

  const StateMessageWidget(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: const BoxDecoration(
        color: greyColor,
        borderRadius: borderRadius,
      ),
      child: Text(data),
    );
  }
}
