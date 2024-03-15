part of 'game_bloc.dart';

@immutable
sealed class GameEvent {}

final class StartBettingEvent extends GameEvent {}

final class StartGameEvent extends GameEvent {}

final class HitEvent extends GameEvent {}

final class StandEvent extends GameEvent {}

final class ResetGameEvent extends GameEvent {}

final class RestartGameEvent extends GameEvent {}

final class ExitGameEvent extends GameEvent {}
