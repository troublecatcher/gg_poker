part of 'dialog_bloc.dart';

@immutable
sealed class DialogEvent {}

final class PauseEvent extends DialogEvent {
  final BuildContext context;

  PauseEvent({required this.context});
}

final class ProfileEvent extends DialogEvent {
  final BuildContext context;

  ProfileEvent({required this.context});
}

final class CloseEvent extends DialogEvent {}
