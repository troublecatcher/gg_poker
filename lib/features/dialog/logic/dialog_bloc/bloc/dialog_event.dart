part of 'dialog_bloc.dart';

@immutable
sealed class DialogEvent {}

final class PauseEvent extends DialogEvent {}

final class ProfileEvent extends DialogEvent {}

final class CloseEvent extends DialogEvent {}
