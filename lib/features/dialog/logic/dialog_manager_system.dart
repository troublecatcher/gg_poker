import 'package:flutter/material.dart' hide Dialog;
import 'package:gg_poker/features/dialog/logic/dialog_bloc/bloc/dialog_bloc.dart';
import 'package:gg_poker/features/dialog/ui/system/dialog_pause.dart';
import 'package:gg_poker/features/dialog/ui/system/dialog_profile.dart';

class DialogManagerSystem {
  static Future<void> showDialog(
      BuildContext context, DialogState state) async {
    if (state is PauseState) {
      DialogPause().showDialog(context);
    } else if (state is ProfileState) {
      DialogProfile().showDialog(context);
    }
  }
}
