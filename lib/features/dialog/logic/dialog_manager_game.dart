import 'package:flutter/material.dart' hide Dialog;
import 'package:gg_poker/features/blackjack/game/logic/game_bloc/game_bloc.dart';
import 'package:gg_poker/features/dialog/ui/game/dialog_lose.dart';
import 'package:gg_poker/features/dialog/ui/game/dialog_push.dart';
import 'package:gg_poker/features/dialog/ui/game/dialog_win.dart';

class DialogManagerGame {
  static Future<void> showDialog(BuildContext context, GameState state) async {
    if (state is WinState) {
      await Future.delayed(const Duration(milliseconds: 1500));
      DialogWin().showDialog(context, state);
    } else if (state is LoseState) {
      await Future.delayed(const Duration(milliseconds: 1500));
      DialogLose().showDialog(context, state);
    } else if (state is PushState) {
      await Future.delayed(const Duration(milliseconds: 1500));
      DialogPush().showDialog(context, state);
    }
  }
}
