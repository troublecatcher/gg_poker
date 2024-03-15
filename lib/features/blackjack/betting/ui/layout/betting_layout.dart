import 'package:flutter/material.dart' hide Chip;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gg_poker/features/blackjack/betting/logic/betting_cubit/betting_cubit.dart';
import 'package:gg_poker/features/blackjack/betting/ui/layout/betting_bottom_bar.dart';
import 'package:gg_poker/features/blackjack/betting/ui/widgets/betting_chip.dart';

class BettingLayout extends StatelessWidget {
  const BettingLayout({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<BettingCubit, List<Chip>>(
                  builder: (context, state) {
                    if (state.isEmpty) {
                      return BettingChip(
                        width: width,
                        chipMode: ChipMode.blank,
                      );
                    } else {
                      return BettingChip(
                          width: width,
                          chipMode: ChipMode.reduce,
                          chip: state.last);
                    }
                  },
                ),
                SizedBox(width: width / 10),
                BlocBuilder<BettingCubit, List<Chip>>(
                  builder: (context, state) {
                    int sum = 0;
                    for (var chip in state) {
                      sum += chip.value;
                    }
                    return Text('\$$sum');
                  },
                ),
              ],
            ),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: [
                ...List.generate(
                  Chip.values.length,
                  (index) => BlocBuilder<BettingCubit, List<Chip>>(
                    builder: (context, state) {
                      final chip = Chip.values[index];
                      if (context
                          .read<BettingCubit>()
                          .sufficientBalance(chip)) {
                        return BettingChip(
                            width: width, chipMode: ChipMode.add, chip: chip);
                      } else {
                        return BettingChip(
                          width: width,
                          chipMode: ChipMode.blank,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: BettingBottomBar(),
        ),
      ],
    );
  }
}
