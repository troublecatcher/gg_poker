import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gg_poker/features/dialog/ui/system/dialog_pause.dart';
import 'package:gg_poker/features/dialog/ui/system/dialog_profile.dart';

part 'dialog_event.dart';
part 'dialog_state.dart';

class DialogBloc extends Bloc<DialogEvent, DialogState> {
  DialogBloc() : super(NoneState()) {
    on<PauseEvent>((event, emit) {
      DialogPause().showDialog(event.context);
      emit(PauseState());
    });
    on<ProfileEvent>((event, emit) {
      DialogProfile().showDialog(event.context);
      emit(ProfileState());
    });
    on<CloseEvent>((event, emit) => emit(NoneState()));
  }
}
