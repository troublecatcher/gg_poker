import 'package:flutter/material.dart' hide Card;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gg_poker/features/blackjack/game/logic/entity/card/card.dart';
import 'package:gg_poker/features/blackjack/game/logic/entity/entity.dart';
import 'package:gg_poker/features/blackjack/game/logic/game_bloc/game_bloc.dart';
import 'package:gg_poker/features/blackjack/game/ui/widgets/card/card_back.dart';
import 'package:gg_poker/features/blackjack/game/ui/widgets/card/card_front.dart';
import 'package:gg_poker/features/blackjack/game/ui/widgets/hand/hand_message_widget.dart';

class Hand extends StatelessWidget {
  const Hand({super.key, required this.entity, required this.hand});

  final Entity entity;
  final List<Card> hand;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Stack(
          children: List.generate(hand.length, (index) {
            final totalCards = hand.length;
            final middleIndex = totalCards ~/ 2;
            final distanceFromMiddle = index - middleIndex;
            final rotationAngle = distanceFromMiddle / 15.0;

            return Padding(
              padding: EdgeInsets.only(left: index * 40),
              child: AnimatedRotation(
                turns: distanceFromMiddle != 0 ? rotationAngle : 0,
                duration: const Duration(milliseconds: 500),
                child: Builder(
                  builder: (context) {
                    if (hand[index].isDisclosed) {
                      return CardFront(card: hand[index]);
                    } else {
                      return const CardBack();
                    }
                  },
                ),
              ),
            );
          }),
        ),
        BlocBuilder<GameBloc, GameState>(
          builder: (context, state) {
            switch (entity) {
              case Entity.player:
                switch (state) {
                  case PlayerBlackjackState _:
                    return HandMessageWidget(state.message);
                  case PlayerBustState _:
                    return HandMessageWidget(state.message);
                  case PlayerWinState _:
                    return HandMessageWidget(state.message);
                  default:
                    return const SizedBox.shrink();
                }
              case Entity.dealer:
                switch (state) {
                  case DealerBlackjackState _:
                    return HandMessageWidget(state.message);
                  case DealerBustState _:
                    return HandMessageWidget(state.message);
                  case DealerWinState _:
                    return HandMessageWidget(state.message);
                  default:
                    return const SizedBox.shrink();
                }
            }
          },
        ),
      ],
    );
  }
}
