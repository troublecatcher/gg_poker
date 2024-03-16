import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:gg_poker/features/blackjack/game/logic/entity/card/card.dart';
import 'package:gg_poker/features/blackjack/game/logic/entity/card/value.dart';

part 'dealer_state.dart';

class DealerCubit extends Cubit<List<Card>> {
  DealerCubit() : super([]);
  getCard(Card card) {
    emit([...state, card]);
  }

  void discloseCards() {
    List<Card> newState = [];
    for (var element in state) {
      newState.add(element.copyWith(isDisclosed: true));
    }
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
