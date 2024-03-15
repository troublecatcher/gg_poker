import 'package:flutter/material.dart' hide Card;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gg_poker/features/blackjack/game/logic/entity.dart';
import 'package:gg_poker/features/blackjack/game/logic/game_bloc/game_bloc.dart';
import 'package:gg_poker/features/blackjack/game/logic/card/card.dart';
import 'package:gg_poker/features/blackjack/game/logic/dealer_cubit/dealer_cubit.dart';
import 'package:gg_poker/features/blackjack/game/logic/player_cubit/player_cubit.dart';
import 'package:gg_poker/features/blackjack/game/ui/cards/deck.dart';
import 'package:gg_poker/features/blackjack/game/ui/cards/hand.dart';
import 'package:gg_poker/features/blackjack/game/ui/layout/game_bottom_bar.dart';
import 'package:gg_poker/features/blackjack/game/ui/widgets/score.dart';
import 'package:gg_poker/theme/widgets/custom_app_bar.dart';
import 'package:gg_poker/theme/const.dart';

class GameLayout extends StatelessWidget {
  const GameLayout({super.key, required this.width});

  final double width;

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
                  const Expanded(child: Deck()),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: BlocBuilder<GameBloc, GameState>(
                builder: (context, gameState) {
                  return BlocBuilder<PlayerCubit, List<Card>>(
                    builder: (context, playerState) =>
                        Hand(hand: playerState, entity: Entity.player),
                  );
                },
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
