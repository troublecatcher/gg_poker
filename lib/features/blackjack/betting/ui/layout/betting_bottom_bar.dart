import 'package:flutter/material.dart' hide Chip;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gg_poker/features/balance/balance_cubit.dart';
import 'package:gg_poker/features/blackjack/betting/logic/bloc/betting_bloc.dart';
import 'package:gg_poker/features/blackjack/game/logic/game_bloc/game_bloc.dart';
import 'package:gg_poker/theme/const.dart';
import 'package:gg_poker/theme/widgets/custom_button.dart';

class BettingBottomBar extends StatelessWidget {
  const BettingBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BettingBloc, List<Chip>>(
      builder: (context, state) {
        return Container(
          color: greyColor,
          child: Padding(
            padding: const EdgeInsets.only(right: 22, left: 22, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (state.isEmpty)
                  Expanded(
                    child: CustomButton(
                        color: primaryRedColor,
                        title: 'All in',
                        icon: SvgPicture.asset('assets/icons/all_in.svg'),
                        onPressed: () => context
                            .read<BettingBloc>()
                            .add(AllInBettingEvent())),
                  )
                else
                  Expanded(
                    child: CustomButton(
                        color: primaryRedColor,
                        title: 'Clear bet',
                        icon: const Icon(Icons.clear_rounded),
                        onPressed: () => context
                            .read<BettingBloc>()
                            .add(ClearBettingEvent())),
                  ),
                const SizedBox(width: 7),
                Expanded(
                  child: CustomButton(
                    color: primaryRedColor,
                    onPressed: state.isNotEmpty
                        ? () {
                            context.read<BalanceCubit>().updateBalance(
                                -context.read<BettingBloc>().sumOfChips());
                            context.read<GameBloc>().add(StartGameEvent());
                          }
                        : null,
                    title: 'Deal',
                    icon: SvgPicture.asset('assets/icons/deal.svg'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
