import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gg_poker/features/blackjack/betting/logic/betting_cubit/betting_cubit.dart';
import 'package:gg_poker/theme/widgets/custom_container.dart';

class DialogBalanceUpdateInfo extends StatelessWidget {
  final String action;
  final int multiplier;
  const DialogBalanceUpdateInfo(
      {super.key, required this.action, required this.multiplier});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: CustomContainer(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            action,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(width: 8),
          Image.asset(
            'assets/chips/biscuit.png',
            width: 28,
            height: 28,
          ),
          const SizedBox(width: 8),
          Text(
            (context.read<BettingCubit>().sumOfChips() * multiplier).toString(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      )),
    );
  }
}
