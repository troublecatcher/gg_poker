import 'package:flutter/material.dart' hide Dialog;
import 'package:gg_poker/features/blackjack/game/logic/game_bloc/game_bloc.dart';
import 'package:gg_poker/features/dialog/ui/dialog.dart';
import 'package:gg_poker/features/dialog/ui/widgets/buttons/dialog_menu_button.dart';
import 'package:gg_poker/features/dialog/ui/widgets/buttons/dialog_play_again_button.dart';
import 'package:gg_poker/features/dialog/ui/widgets/dialog_title.dart';
import 'package:gg_poker/features/dialog/ui/widgets/dialog_frame.dart';

class DialogPush extends Dialog {
  void showDialog(BuildContext context, PushState pushState) {
    Widget widget = DialogFrame(
        child: Column(
      children: [
        DialogTitle(pushState.title),
        const SizedBox(height: 26),
        const DialogPlayAgainButton(),
        const SizedBox(height: 8),
        const DialogMenuButton(),
      ],
    ));
    build(context, widget);
  }
}
