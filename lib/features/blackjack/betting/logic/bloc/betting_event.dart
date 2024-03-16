part of 'betting_bloc.dart';

@immutable
sealed class BettingEvent {}

final class AddChipBettingEvent extends BettingEvent {
  final Chip chip;

  AddChipBettingEvent({required this.chip});
}

final class PopChipBettingEvent extends BettingEvent {}

final class AllInBettingEvent extends BettingEvent {}

final class ClearBettingEvent extends BettingEvent {}
