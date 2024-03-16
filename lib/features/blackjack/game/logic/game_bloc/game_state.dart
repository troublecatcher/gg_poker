part of 'game_bloc.dart';

@immutable
sealed class GameState {}

final class IdleState extends GameState {}

final class BettingState extends GameState {}

final class OngoingState extends GameState {}

final class GivingPlayerCardState extends GameState {}

final class GivingDealerCardState extends GameState {}

abstract class WinState extends GameState {
  final String title = 'Good play!';
  final String action = '+';
  final int multiplier = 2;
}

final class DealerBustState extends WinState {
  final String message = 'Dealer Bust!';
}

final class PlayerWinState extends WinState {
  final String message = 'You win!';
}

final class PlayerBlackjackState extends WinState {
  final String message = 'Blackjack!';
}

abstract class LoseState extends GameState {
  final String title = 'Oops!\nBetter luck next time';
  final String action = '—';
  final int multiplier = 1;
}

final class PlayerBustState extends LoseState {
  final String message = 'You Bust!';
}

final class DealerWinState extends LoseState {
  final String message = 'Dealer Wins!';
}

final class DealerBlackjackState extends LoseState {
  final String message = 'Dealer Blackjack!';
}

final class PushState extends GameState {
  final String title = 'Push!\nYou got your bet back';
}
