import 'package:flutter/material.dart' hide Chip;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gg_poker/features/blackjack/game/logic/game_bloc/game_bloc.dart';
import 'package:gg_poker/theme/const.dart';
import 'package:gg_poker/theme/widgets/custom_button.dart';

class GameBottomBar extends StatelessWidget {
  const GameBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: greyColor,
      child: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(right: 22, left: 22, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: CustomButton(
                    color: primaryRedColor,
                    onPressed: state is OngoingState
                        ? () => context.read<GameBloc>().add(HitEvent())
                        : null,
                    children: const [
                      Icon(Icons.library_add),
                      Text('Hit'),
                    ],
                  ),
                ),
                const SizedBox(width: 7),
                Expanded(
                  child: CustomButton(
                    color: primaryRedColor,
                    onPressed: state is OngoingState
                        ? () => context.read<GameBloc>().add(StandEvent())
                        : null,
                    children: [
                      SvgPicture.asset('assets/icons/stand.svg'),
                      const Text('Stand'),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
