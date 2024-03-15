import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide Dialog;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gg_poker/features/blackjack/game/logic/game_bloc/game_bloc.dart';
import 'package:gg_poker/features/dialog/logic/dialog_bloc/bloc/dialog_bloc.dart';
import 'package:gg_poker/features/dialog/ui/dialog.dart';
import 'package:gg_poker/router/router.dart';
import 'package:gg_poker/theme/const.dart';
import 'package:gg_poker/theme/widgets/custom_button.dart';

class DialogPause extends Dialog {
  void showDialog(BuildContext context) {
    Widget widget = Padding(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        children: [
          Text(
            'Pause',
            style: Theme.of(context).textTheme.displayLarge,
            textAlign: TextAlign.center,
          ),
          CustomButton(
              color: primaryRedColor,
              children: const [
                Icon(Icons.play_arrow_rounded),
                Text('Back to game'),
              ],
              onPressed: () {
                context.read<DialogBloc>().add(CloseEvent());
                context.router.popForced();
              }),
          const SizedBox(height: 8),
          CustomButton(
              color: secondaryButtonColor,
              children: const [
                Text('Menu'),
              ],
              onPressed: () async {
                context.router.popForced();
                context.router.replace(const HomeRoute());
                context.read<GameBloc>().add(ResetGameEvent());
                context.read<GameBloc>().add(ExitGameEvent());
              }),
        ],
      ),
    );
    build(context, widget, false, Colors.black87);
  }
}
