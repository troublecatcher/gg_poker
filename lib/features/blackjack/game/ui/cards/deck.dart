import 'package:flutter/material.dart';
import 'package:gg_poker/features/blackjack/game/ui/cards/card_back.dart';

class Deck extends StatelessWidget {
  const Deck({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Stack(
        alignment: Alignment.center,
        children: List.generate(
            4,
            (index) => Container(
                  height: height / 4 + index * 5,
                  margin: EdgeInsets.only(left: index * 12.5),
                  child: const CardBack(),
                )));
  }
}
