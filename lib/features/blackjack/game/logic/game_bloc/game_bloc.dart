import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gg_poker/features/balance/balance_cubit.dart';
import 'package:gg_poker/features/blackjack/betting/logic/bloc/betting_bloc.dart';

import '../entity/dealer/dealer_cubit.dart';
import '../entity/deck/deck_cubit.dart';
import '../entity/player/player_cubit.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final PlayerCubit playerCubit;
  final DealerCubit dealerCubit;
  final DeckCubit deckCubit;
  final BettingBloc bettingBloc;
  final BalanceCubit balanceCubit;
  GameBloc({
    required this.playerCubit,
    required this.dealerCubit,
    required this.deckCubit,
    required this.bettingBloc,
    required this.balanceCubit,
  }) : super(IdleState()) {
    on<StartBettingEvent>((event, emit) => emit(BettingState()));

    on<StartGameEvent>((event, emit) async {
      await delay(() => emit(GivingPlayerCardState())).whenComplete(() async {
        await _initHands(emit).whenComplete(() async {
          emit(OngoingState());
          await checkForPlayerBlackjack(emit);
        });
      });
    });

    on<HitEvent>((event, emit) async {
      await delay(() => emit(GivingPlayerCardState())).whenComplete(() {
        playerCubit.getCard(deckCubit.getCard(disclosed: true));
        emit(OngoingState());
      });
      if (playerCubit.sumOfCards() > 21) {
        dealerCubit.discloseCards();
        emit(PlayerBustState());
      }
      checkForPlayerBlackjack(emit);
    });

    on<StandEvent>((event, emit) async {
      dealerCubit.discloseCards();
      await topUpDealerHand(emit).whenComplete(() => checkResult(emit));
    });

    on<ResetGameEvent>((event, emit) {
      playerCubit.clear();
      dealerCubit.clear();
      deckCubit.reset();
      bettingBloc.add(ClearBettingEvent());
    });

    on<RestartGameEvent>((event, emit) {
      add(ResetGameEvent());
      emit(BettingState());
    });

    on<ExitGameEvent>((event, emit) => emit(IdleState()));
  }

  Future<void> checkForPlayerBlackjack(Emitter<GameState> emit) async {
    if (playerCubit.sumOfCards() == 21) {
      balanceCubit.updateBalance(bettingBloc.sumOfChips() * 2);
      emit(PlayerBlackjackState());
    }
  }

  Future<void> checkResult(Emitter<GameState> emit) async {
    final playerScore = playerCubit.sumOfCards();
    final dealerScore = dealerCubit.sumOfCards();
    if (dealerScore == 21) {
      emit(DealerBlackjackState());
    } else if (dealerScore > 21) {
      balanceCubit.updateBalance(bettingBloc.sumOfChips() * 2);
      emit(DealerBustState());
    } else if (dealerScore > playerScore) {
      emit(DealerWinState());
    } else if (dealerScore < playerScore) {
      balanceCubit.updateBalance(bettingBloc.sumOfChips() * 2);
      emit(PlayerWinState());
    } else if (dealerScore == playerScore) {
      balanceCubit.updateBalance(bettingBloc.sumOfChips());
      emit(PushState());
    }
  }

  Future<void> topUpDealerHand(Emitter<GameState> emit) async {
    while (dealerCubit.sumOfCards() <= 16) {
      await delay(() => emit(GivingDealerCardState())).whenComplete(
          () => dealerCubit.getCard(deckCubit.getCard(disclosed: true)));
    }
  }

  Future<void> delay(void Function() emit) async {
    emit();
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> _initHands(Emitter<GameState> emit) async {
    await delay(() => emit(GivingPlayerCardState())).whenComplete(
        () => playerCubit.getCard(deckCubit.getCard(disclosed: true)));

    await delay(() => emit(GivingDealerCardState())).whenComplete(
        () => dealerCubit.getCard(deckCubit.getCard(disclosed: true)));

    await delay(() => emit(GivingPlayerCardState())).whenComplete(
        () => playerCubit.getCard(deckCubit.getCard(disclosed: true)));

    await delay(() => emit(GivingDealerCardState())).whenComplete(
        () => dealerCubit.getCard(deckCubit.getCard(disclosed: false)));
  }
}
