import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'dialog_event.dart';
part 'dialog_state.dart';

class DialogBloc extends Bloc<DialogEvent, DialogState> {
  DialogBloc() : super(NoneState()) {
    on<PauseEvent>((event, emit) => emit(PauseState()));
    on<ProfileEvent>((event, emit) => emit(ProfileState()));
    on<CloseEvent>((event, emit) => emit(NoneState()));
  }
}
