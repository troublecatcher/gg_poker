part of 'betting_bloc.dart';

@immutable
sealed class BettingState {}

final class AddChipBettingState extends BettingState {
  final List<Chip> chips;

  AddChipBettingState(this.chips);
}
