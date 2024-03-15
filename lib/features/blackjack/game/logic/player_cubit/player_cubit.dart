import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:gg_poker/features/blackjack/game/logic/card/card.dart';
import 'package:gg_poker/features/blackjack/game/logic/card/value.dart';

part 'player_state.dart';

class PlayerCubit extends Cubit<List<Card>> {
  PlayerCubit() : super([]);

  getCard(Card card, [int handIndex = 0]) {
    final newState = List.of(state);
    newState.add(card);
    emit(newState);
  }

  int sumOfCards() {
    int sum = 0;
    int aceCount = 0;

    for (var card in state) {
      if (card.isDisclosed) {
        if (card.value == Value.ace) {
          aceCount++;
        } else {
          sum += card.value.intValue;
        }
      }
    }

    for (int i = 0; i < aceCount; i++) {
      if (sum + 11 <= 21) {
        sum += 11;
      } else {
        sum += 1;
      }
    }

    return sum;
  }

  clear() {
    emit([]);
  }
}
