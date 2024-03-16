import 'package:flutter/material.dart';
import 'package:gg_poker/theme/const.dart';

enum Suit {
  hearts(color: heartsColor),
  spades(color: spadesColor),
  diamonds(color: diamondsColor),
  clubs(color: clubsColor);

  final Color color;

  const Suit({required this.color});
}
