import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CardBack extends StatelessWidget {
  const CardBack({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SvgPicture.asset(
      'assets/cards/blank.svg',
      width: width / 4,
      height: height / 6,
    );
  }
}
