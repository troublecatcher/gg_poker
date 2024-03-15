part of 'dialog_bloc.dart';

@immutable
sealed class DialogState {}

class NoneState extends DialogState {}

class PauseState extends DialogState {}

final class ProfileState extends DialogState {}
