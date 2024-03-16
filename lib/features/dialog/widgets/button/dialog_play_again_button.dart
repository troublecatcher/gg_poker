import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gg_poker/features/blackjack/game/logic/game_bloc/game_bloc.dart';
import 'package:gg_poker/theme/const.dart';
import 'package:gg_poker/theme/widgets/custom_button.dart';

class DialogPlayAgainButton extends StatelessWidget {
  const DialogPlayAgainButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      color: primaryRedColor,
      title: 'Play again',
      icon: const Icon(Icons.play_arrow_rounded),
      onPressed: () {
        context.router.popForced();
        context.read<GameBloc>().add(RestartGameEvent());
      },
    );
  }
}
