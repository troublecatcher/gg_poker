import 'package:flutter/material.dart' hide Dialog;
import 'package:gg_poker/features/blackjack/game/logic/game_bloc/game_bloc.dart';
import 'package:gg_poker/features/dialog/ui/dialog.dart';
import 'package:gg_poker/features/dialog/widgets/dialog_balance_update_info.dart';
import 'package:gg_poker/features/dialog/widgets/button/dialog_menu_button.dart';
import 'package:gg_poker/features/dialog/widgets/button/dialog_play_again_button.dart';
import 'package:gg_poker/features/dialog/widgets/dialog_frame.dart';
import 'package:gg_poker/features/dialog/widgets/dialog_title.dart';
import 'package:gg_poker/theme/const.dart';

class DialogWin extends Dialog {
  void showDialog(BuildContext context, WinState winState) {
    final size = MediaQuery.of(context).size;
    Widget widget = SizedBox(
      height: size.height * .5,
      child: Stack(
        children: [
          Positioned(
              top: (size.height * .2) / 2,
              right: 0,
              left: 0,
              child: DialogFrame(
                child: Column(
                  children: [
                    DialogTitle(winState.title),
                    const SizedBox(height: 26),
                    DialogBalanceUpdateInfo(
                      action: winState.action,
                      multiplier: winState.multiplier,
                    ),
                    const SizedBox(height: 8),
                    const DialogPlayAgainButton(),
                    const SizedBox(height: 8),
                    const DialogMenuButton(),
                  ],
                ),
              )),
          Align(
            alignment: const Alignment(0, -0.85),
            child: Container(
              width: size.width * 0.25,
              height: size.width * 0.25,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: biscuitGlowColor,
                    spreadRadius: 2,
                    blurRadius: 30,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Image.asset(
                'assets/chips/biscuit.png',
              ),
            ),
          ),
        ],
      ),
    );
    build(context, widget);
  }
}
