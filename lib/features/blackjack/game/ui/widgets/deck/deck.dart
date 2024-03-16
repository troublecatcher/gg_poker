import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gg_poker/features/blackjack/game/logic/game_bloc/game_bloc.dart';
import 'package:gg_poker/features/blackjack/game/ui/widgets/card/card_back.dart';
import 'package:gg_poker/features/blackjack/game/ui/widgets/deck/deck_animated_card.dart';

class Deck extends StatefulWidget {
  const Deck({super.key});

  @override
  State<Deck> createState() => _DeckState();
}

class _DeckState extends State<Deck> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animation = Tween<Offset>(begin: Offset.zero, end: const Offset(-1, -1))
        .animate(
            CurvedAnimation(parent: controller, curve: Curves.easeOutExpo));
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocListener<GameBloc, GameState>(
      listener: (context, state) {
        if (state is GivingPlayerCardState) {
          setState(() {
            animation =
                Tween<Offset>(begin: Offset.zero, end: const Offset(-1, 1))
                    .animate(CurvedAnimation(
                        parent: controller, curve: Curves.easeOutExpo));
          });
          controller.reset();
          controller.forward().whenComplete(() => controller.reset());
        }
        if (state is GivingDealerCardState) {
          setState(() {
            animation =
                Tween<Offset>(begin: Offset.zero, end: const Offset(-1, -1))
                    .animate(CurvedAnimation(
                        parent: controller, curve: Curves.easeOutExpo));
          });
          controller.reset();
          controller.forward().whenComplete(() => controller.reset());
        }
      },
      child: Stack(
          alignment: Alignment.center,
          children: List.generate(4, (index) {
            if (index == 3) {
              return SlideTransition(
                position: animation,
                child: const DeckAnimatedCard(),
              );
            }
            return Container(
              height: height / 4 + index * 5,
              margin: EdgeInsets.only(left: index * 12.5),
              child: const CardBack(),
            );
          })),
    );
  }
}
