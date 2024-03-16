import 'package:flutter/material.dart' hide Chip;
import 'package:gg_poker/features/blackjack/betting/logic/bloc/betting_bloc.dart';

class BettingChipAnimated extends StatefulWidget {
  const BettingChipAnimated({
    super.key,
    this.chip,
    required this.index,
    required this.controller,
  });

  final Chip? chip;
  final int index;
  final AnimationController controller;

  @override
  State<BettingChipAnimated> createState() => _BettingChipAnimatedState();
}

class _BettingChipAnimatedState extends State<BettingChipAnimated> {
  late final Animation<Offset> animation;
  @override
  void initState() {
    super.initState();
    animation = Tween<Offset>(
      begin: Offset.zero,
      end: _calculateEndOffset(widget.index),
    ).animate(CurvedAnimation(parent: widget.controller, curve: Curves.ease));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SlideTransition(
      position: animation,
      child: SizedBox(
        width: size.width / 3 - 16,
        height: size.width / 3 - 16,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(widget.chip!.assetPath),
            Text(
              widget.chip!.value.toString(),
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ],
        ),
      ),
    );
  }

  Offset _calculateEndOffset(int index) {
    double dX = 0;
    double dY = 0;
    switch (index) {
      case 0:
        dX = 1.065;
        dY = -2;
        break;
      case 1:
        dX = 0;
        dY = -2;
        break;
      case 2:
        dX = -1.065;
        dY = -2;
        break;
      case 3:
        dX = 0.53;
        dY = -3.05;
        break;
      case 4:
        dX = -0.53;
        dY = -3.05;
        break;
      default:
    }
    dX = dX;
    dY = dY;
    return Offset(dX, dY);
  }
}
