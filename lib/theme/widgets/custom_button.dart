import 'package:flutter/material.dart';
import 'package:gg_poker/theme/const.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final Function()? onPressed;
  final List<Widget> children;

  const CustomButton(
      {super.key, required this.color, this.onPressed, required this.children});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            backgroundColor: color,
            foregroundColor: Colors.white,
            disabledBackgroundColor: disabledButtonColor,
            disabledForegroundColor: Colors.white,
            splashFactory: NoSplash.splashFactory,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            )),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        ));
  }
}
