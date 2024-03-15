import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart' hide Chip;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gg_poker/features/blackjack/betting/logic/betting_cubit/betting_cubit.dart';

enum ChipMode { blank, add, reduce }

class BettingChip extends StatelessWidget {
  const BettingChip({
    super.key,
    required this.width,
    this.chip,
    required this.chipMode,
  });

  final double width;
  final Chip? chip;
  final ChipMode chipMode;

  @override
  Widget build(BuildContext context) {
    switch (chipMode) {
      case ChipMode.blank:
        return DottedBorder(
          color: Colors.white,
          strokeWidth: 1,
          borderType: BorderType.Circle,
          child: SizedBox(
            width: width / 3 - 16,
            height: width / 3 - 16,
          ),
        );
      default:
        return GestureDetector(
          onTap: chipMode == ChipMode.add
              ? () => context.read<BettingCubit>().addChip(chip!)
              : () => context.read<BettingCubit>().popChip(),
          child: SizedBox(
            width: width / 3 - 16,
            height: width / 3 - 16,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(chip!.assetPath),
                Text(
                  chip!.value.toString(),
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ],
            ),
          ),
        );
    }
  }
}
