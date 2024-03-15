import 'package:flutter/material.dart';

class DialogTitle extends StatelessWidget {
  final String title;

  const DialogTitle(
    this.title, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
