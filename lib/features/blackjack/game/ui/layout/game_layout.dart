import 'package:flutter/material.dart' hide Card;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gg_poker/features/blackjack/game/logic/entity/entity.dart';
import 'package:gg_poker/features/blackjack/game/logic/entity/card/card.dart';
import 'package:gg_poker/features/blackjack/game/logic/entity/dealer/dealer_cubit.dart';
import 'package:gg_poker/features/blackjack/game/logic/entity/player/player_cubit.dart';
import 'package:gg_poker/features/blackjack/game/ui/widgets/deck/deck.dart';
import 'package:gg_poker/features/blackjack/game/ui/widgets/hand/hand.dart';
import 'package:gg_poker/features/blackjack/game/ui/layout/game_bottom_bar.dart';
import 'package:gg_poker/features/blackjack/game/ui/widgets/score.dart';

class GameLayout extends StatelessWidget {
  const GameLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: BlocBuilder<DealerCubit, List<Card>>(
                builder: (context, state) {
                  return Hand(hand: state, entity: Entity.dealer);
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  const Expanded(child: Score()),
                  const Expanded(
                      child: Stack(
                    children: [
                      Deck(),
                    ],
                  )),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: BlocBuilder<PlayerCubit, List<Card>>(
                builder: (context, playerState) =>
                    Hand(hand: playerState, entity: Entity.player),
              ),
            )
          ],
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: GameBottomBar(),
        ),
      ],
    );
  }
}
