import 'package:flutter/material.dart' hide Card;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gg_poker/features/blackjack/game/logic/card/card.dart';
import 'package:gg_poker/features/blackjack/game/logic/dealer_cubit/dealer_cubit.dart';
import 'package:gg_poker/features/blackjack/game/logic/player_cubit/player_cubit.dart';
import 'package:gg_poker/theme/widgets/custom_container.dart';

class Score extends StatelessWidget {
  const Score({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<DealerCubit, List<Card>>(
          builder: (context, state) {
            return CustomContainer(
                child:
                    Text(context.read<DealerCubit>().sumOfCards().toString()));
          },
        ),
        const SizedBox(height: 44),
        BlocBuilder<PlayerCubit, List<Card>>(
          builder: (context, state) {
            return CustomContainer(
                child:
                    Text(context.read<PlayerCubit>().sumOfCards().toString()));
          },
        ),
      ],
    );
  }
}
