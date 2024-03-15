import 'package:flutter/material.dart';
import 'package:gg_poker/theme/const.dart';

final theme = ThemeData(
    splashColor: Colors.transparent,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryRedColor,
      brightness: Brightness.dark,
    ),
    appBarTheme: const AppBarTheme(backgroundColor: greyColor));
