import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';

abstract class Dialog {
  void build(BuildContext context, Widget widget,
      [bool barrierDismissible = false, Color barrierColor = Colors.black38]) {
    final size = MediaQuery.of(context).size;
    YYDialog().build(context)
      ..barrierColor = barrierColor
      ..width = size.width * 0.8
      ..backgroundColor = Colors.transparent
      ..barrierDismissible = barrierDismissible
      ..animatedFunc = (child, animation) {
        return ScaleTransition(
          scale: Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutExpo,
              reverseCurve: Curves.easeInExpo,
            ),
          ),
          child: child,
        );
      }
      ..widget(widget)
      ..show();
  }
}
