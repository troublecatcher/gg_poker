import 'package:flutter/material.dart' hide Dialog;
import 'package:gg_poker/features/blackjack/game/logic/game_bloc/game_bloc.dart';
import 'package:gg_poker/features/dialog/ui/dialog.dart';
import 'package:gg_poker/features/dialog/widgets/dialog_balance_update_info.dart';
import 'package:gg_poker/features/dialog/widgets/button/dialog_menu_button.dart';
import 'package:gg_poker/features/dialog/widgets/button/dialog_play_again_button.dart';
import 'package:gg_poker/features/dialog/widgets/dialog_frame.dart';
import 'package:gg_poker/features/dialog/widgets/dialog_title.dart';

class DialogLose extends Dialog {
  void showDialog(BuildContext context, LoseState loseState) {
    Widget widget = DialogFrame(
      child: Column(
        children: [
          DialogTitle(loseState.title),
          const SizedBox(height: 26),
          DialogBalanceUpdateInfo(
            action: loseState.action,
            multiplier: loseState.multiplier,
          ),
          const SizedBox(height: 8),
          const DialogPlayAgainButton(),
          const SizedBox(height: 8),
          const DialogMenuButton(),
        ],
      ),
    );
    build(context, widget);
  }
}
