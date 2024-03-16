import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart' hide Chip;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gg_poker/features/blackjack/betting/logic/bloc/betting_bloc.dart';

enum ChipMode { blank, add, reduce }

class BettingChip extends StatelessWidget {
  const BettingChip({
    super.key,
    this.chip,
    required this.chipMode,
    required this.index,
  });

  final Chip? chip;
  final ChipMode chipMode;
  final int index;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    switch (chipMode) {
      case ChipMode.blank:
        return SizedBox(
          width: size.width / 3 - 16,
          height: size.width / 3 - 16,
          child: DottedBorder(
            color: Colors.white,
            strokeWidth: 1,
            borderType: BorderType.Circle,
            child: Container(),
          ),
        );
      default:
        return GestureDetector(
          onTap: chipMode == ChipMode.add
              ? () {
                  context
                      .read<BettingBloc>()
                      .add(AddChipBettingEvent(chip: chip!));
                }
              : () {
                  context.read<BettingBloc>().add(PopChipBettingEvent());
                },
          child: SizedBox(
            width: size.width / 3 - 16,
            height: size.width / 3 - 16,
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
