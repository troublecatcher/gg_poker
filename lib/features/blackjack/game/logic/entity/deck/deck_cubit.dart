import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:gg_poker/features/blackjack/game/logic/entity/card/card.dart';
import 'package:gg_poker/features/blackjack/game/logic/entity/card/suit.dart';
import 'package:gg_poker/features/blackjack/game/logic/entity/card/value.dart';

part 'deck_state.dart';

class DeckCubit extends Cubit<List<Card>> {
  DeckCubit() : super([]) {
    initDeck();
  }

  void initDeck() {
    for (int i = 0; i < Value.values.length; i++) {
      for (int j = 0; j < Suit.values.length; j++) {
        state.add(Card(
            suit: Suit.values[j], value: Value.values[i], isDisclosed: false));
      }
    }
    state.shuffle();
  }

  Card getCard({required bool disclosed}) {
    final newState = List.of(state);
    final lastCard = newState.removeLast();
    emit(newState);
    if (disclosed) {
      lastCard.isDisclosed = true;
    }
    return lastCard;
  }

  reset() {
    emit([]);
    initDeck();
  }
}
