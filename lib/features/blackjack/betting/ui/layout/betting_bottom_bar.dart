import 'package:flutter/material.dart' hide Chip;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gg_poker/features/balance/balance_cubit.dart';
import 'package:gg_poker/features/blackjack/betting/logic/betting_cubit/betting_cubit.dart';
import 'package:gg_poker/features/blackjack/game/logic/game_bloc/game_bloc.dart';
import 'package:gg_poker/theme/const.dart';
import 'package:gg_poker/theme/widgets/custom_button.dart';

class BettingBottomBar extends StatelessWidget {
  const BettingBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BettingCubit, List<Chip>>(
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
                        children: [
                          SvgPicture.asset('assets/icons/all_in.svg'),
                          const Text('All in'),
                        ],
                        onPressed: () => context.read<BettingCubit>().allIn()),
                  )
                else
                  Expanded(
                    child: CustomButton(
                        color: primaryRedColor,
                        children: const [
                          Icon(Icons.clear_rounded),
                          Text('Clear bet'),
                        ],
                        onPressed: () => context.read<BettingCubit>().clear()),
                  ),
                const SizedBox(width: 7),
                Expanded(
                  child: CustomButton(
                    color: primaryRedColor,
                    onPressed: state.isNotEmpty
                        ? () {
                            context.read<BalanceCubit>().updateBalance(
                                -context.read<BettingCubit>().sumOfChips());
                            context.read<GameBloc>().add(StartGameEvent());
                          }
                        : null,
                    children: [
                      SvgPicture.asset('assets/icons/deal.svg'),
                      const Text('Deal'),
                    ],
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
