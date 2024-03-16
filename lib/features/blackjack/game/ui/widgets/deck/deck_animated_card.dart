import 'package:flutter/material.dart';
import 'package:gg_poker/features/blackjack/game/ui/widgets/card/card_back.dart';

class DeckAnimatedCard extends StatelessWidget {
  const DeckAnimatedCard({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: height / 4 + 3 * 5,
      margin: const EdgeInsets.only(left: 3 * 12.5),
      child: const CardBack(),
    );
  }
}
