import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gg_poker/features/balance/balance_cubit.dart';
import 'package:gg_poker/features/blackjack/betting/logic/betting_cubit/betting_cubit.dart';

import '../dealer_cubit/dealer_cubit.dart';
import '../deck_cubit/deck_cubit.dart';
import '../player_cubit/player_cubit.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final PlayerCubit player;
  final DealerCubit dealer;
  final DeckCubit deck;
  final BettingCubit bet;
  final BalanceCubit balance;
  GameBloc({
    required this.player,
    required this.dealer,
    required this.deck,
    required this.bet,
    required this.balance,
  }) : super(IdleState()) {
    on<StartBettingEvent>((event, emit) => emit(BettingState()));

    on<StartGameEvent>((event, emit) {
      _initHands();
      emit(OngoingState());
      checkForPlayerBlackjack(emit);
    });

    on<HitEvent>((event, emit) {
      player.getCard(deck.getCard(disclosed: true));
      if (player.sumOfCards() > 21) {
        dealer.discloseCards();
        emit(PlayerBustState());
      }
      checkForPlayerBlackjack(emit);
    });

    on<StandEvent>((event, emit) {
      dealer.discloseCards();
      checkResult(emit);
    });

    on<ResetGameEvent>((event, emit) {
      player.clear();
      dealer.clear();
      deck.reset();
      bet.clear();
    });

    on<RestartGameEvent>((event, emit) {
      add(ResetGameEvent());
      emit(BettingState());
    });

    on<ExitGameEvent>((event, emit) => emit(IdleState()));
  }

  void checkForPlayerBlackjack(Emitter<GameState> emit) {
    if (player.sumOfCards() == 21) {
      balance.updateBalance(bet.sumOfChips() * 2);
      emit(PlayerBlackjackState());
    }
  }

  void checkResult(Emitter<GameState> emit) {
    while (dealer.sumOfCards() <= 16) {
      dealer.getCard(deck.getCard(disclosed: true));
    }
    final playerScore = player.sumOfCards();
    final dealerScore = dealer.sumOfCards();
    if (dealerScore == 21) {
      emit(DealerBlackjackState());
    } else if (dealerScore > 21) {
      balance.updateBalance(bet.sumOfChips() * 2);
      emit(DealerBustState());
    } else if (dealerScore > playerScore) {
      emit(DealerWinState());
    } else if (dealerScore < playerScore) {
      balance.updateBalance(bet.sumOfChips() * 2);
      emit(PlayerWinState());
    } else if (dealerScore == playerScore) {
      balance.updateBalance(bet.sumOfChips());
      emit(PushState());
    }
  }

  void _initHands() {
    for (var i = 0; i < 2; i++) {
      player.getCard(deck.getCard(disclosed: true));
    }
    dealer.getCard(deck.getCard(disclosed: true));
    dealer.getCard(deck.getCard(disclosed: false));
  }
}
