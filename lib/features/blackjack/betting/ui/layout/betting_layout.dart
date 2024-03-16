import 'dart:async';
import 'package:flutter/material.dart' hide Chip;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gg_poker/features/blackjack/betting/logic/bloc/betting_bloc.dart';
import 'package:gg_poker/features/blackjack/betting/ui/layout/betting_bottom_bar.dart';
import 'package:gg_poker/features/blackjack/betting/ui/widgets/betting_chip.dart';
import 'package:gg_poker/features/blackjack/betting/ui/widgets/betting_chip_animated.dart';
import 'package:gg_poker/theme/widgets/custom_container.dart';

class BettingLayout extends StatefulWidget {
  const BettingLayout({
    super.key,
  });

  @override
  State<BettingLayout> createState() => _BettingLayoutState();
}

class _BettingLayoutState extends State<BettingLayout>
    with TickerProviderStateMixin {
  late Map<Chip, AnimationController> chipControllersMap;
  late StreamSubscription streamSubscription;
  late List<Chip> previousState = [];

  @override
  void initState() {
    super.initState();
    chipControllersMap = {};
    for (var i = 0; i < 5; i++) {
      chipControllersMap[Chip.values[i]] = AnimationController(
          vsync: this, duration: const Duration(milliseconds: 500));
    }

    streamSubscription =
        BlocProvider.of<BettingBloc>(context).stream.listen((state) {
      if (state.isEmpty && previousState.isNotEmpty) {
        for (final chip in previousState) {
          for (final pair in chipControllersMap.entries) {
            if (chip == pair.key) {
              pair.value.value = 1;
              pair.value.reverse();
            }
          }
        }
      } else if (previousState.length < state.length) {
        chipControllersMap[state.last]!.reset();
        chipControllersMap[state.last]!
            .forward()
            .whenComplete(() => chipControllersMap[state.last]!.reset());
      } else if (previousState.length > state.length) {
        chipControllersMap[previousState.last]!.value = 1;
        chipControllersMap[previousState.last]!.reverse();
      }
      previousState = List.of(state);
    });
  }

  @override
  void dispose() {
    for (final controller in chipControllersMap.values) {
      controller.dispose();
    }
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<BettingBloc, List<Chip>>(
                    builder: (context, state) {
                      if (state.isEmpty) {
                        return const BettingChip(
                          chipMode: ChipMode.blank,
                          index: 0,
                        );
                      } else {
                        return BettingChip(
                          chipMode: ChipMode.reduce,
                          chip: state.last,
                          index: 0,
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomContainer(
                    child: BlocBuilder<BettingBloc, List<Chip>>(
                      builder: (context, state) {
                        int sum = 0;
                        for (var chip in state) {
                          sum += chip.value;
                        }
                        return FittedBox(
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/chips/biscuit.png',
                                width: 40,
                                height: 40,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '$sum',
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
              const Divider(
                indent: 16,
                endIndent: 16,
              ),
              const SizedBox(height: 20),
              Stack(
                children: [
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ...List.generate(
                        Chip.values.length,
                        (index) {
                          return BlocBuilder<BettingBloc, List<Chip>>(
                            builder: (context, state) {
                              final chip = Chip.values[index];
                              if (context
                                  .read<BettingBloc>()
                                  .sufficientBalance(chip)) {
                                return BettingChipAnimated(
                                  chip: chip,
                                  index: index,
                                  controller: chipControllersMap[chip]!,
                                );
                              } else {
                                return Opacity(
                                  opacity: 0.1,
                                  child: BettingChipAnimated(
                                    chip: chip,
                                    index: index,
                                    controller: chipControllersMap[chip]!,
                                  ),
                                );
                              }
                            },
                          );
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
                        (index) => BlocBuilder<BettingBloc, List<Chip>>(
                          builder: (context, state) {
                            final chip = Chip.values[index];
                            if (context
                                .read<BettingBloc>()
                                .sufficientBalance(chip)) {
                              return BettingChip(
                                chipMode: ChipMode.add,
                                chip: chip,
                                index: index,
                              );
                            } else {
                              return BettingChip(
                                chipMode: ChipMode.blank,
                                index: index,
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: BettingBottomBar(),
        ),
      ],
    );
  }
}
