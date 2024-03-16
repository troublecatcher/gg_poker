import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gg_poker/features/reward/logic/rewards.dart';
import 'package:gg_poker/features/reward/logic/spin_result_cubit.dart';
import 'package:gg_poker/theme/const.dart';

class WheelStatusWidget extends StatelessWidget {
  const WheelStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<SpinResultCubit, Reward?>(
      builder: (context, state) {
        return SizedBox(
          width: size.width * 0.8,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                width: size.width * 0.8,
                decoration: const BoxDecoration(
                  color: primaryRedColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                child: Text(
                  context.read<SpinResultCubit>().state == null
                      ? 'Spin!'
                      : context
                          .read<SpinResultCubit>()
                          .state!
                          .rewardMessage
                          .message,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.8,
                decoration: BoxDecoration(
                  color: semiBlackColor,
                  border: Border.all(width: 4, color: primaryRedColor),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: Builder(
                  builder: (context) {
                    if (context.read<SpinResultCubit>().state == null) {
                      return Text(
                        '???',
                        style: Theme.of(context).textTheme.displaySmall,
                      );
                    } else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '+',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          const SizedBox(width: 5),
                          Image.asset(
                            'assets/chips/biscuit.png',
                            width: 28,
                            height: 28,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            context
                                .read<SpinResultCubit>()
                                .state!
                                .value
                                .toString(),
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
