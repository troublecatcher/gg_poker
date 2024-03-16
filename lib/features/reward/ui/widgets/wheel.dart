import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gg_poker/features/reward/logic/spin_cubit.dart';
import 'package:gg_poker/features/reward/logic/spin_result_cubit.dart';
import 'package:gg_poker/features/reward/logic/spinning_state_cubit.dart';
import 'package:gg_poker/theme/const.dart';
import 'package:kbspinningwheel/kbspinningwheel.dart';

class Wheel extends StatefulWidget {
  const Wheel({super.key});

  @override
  State<Wheel> createState() => _WheelState();
}

class _WheelState extends State<Wheel> {
  late StreamController _dividerController;
  late StreamController _wheelNotifier;

  @override
  void initState() {
    super.initState();
    _dividerController = StreamController<int>();
    _wheelNotifier = StreamController<double>();
  }

  @override
  void dispose() {
    super.dispose();
    _dividerController.close();
    _wheelNotifier.close();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        SpinningWheel(
          image: Image.asset(
            'assets/reward/wheel.png',
            width: size.height / 3,
            height: size.height / 3,
          ),
          secondaryImage: Image.asset('assets/reward/pointer1.png'),
          secondaryImageHeight: size.height / 3,
          secondaryImageWidth: size.height / 3,
          width: size.height / 3,
          height: size.height / 3,
          initialSpinAngle: 0,
          spinResistance: 0.4,
          canInteractWhileSpinning: false,
          dividers: 20,
          onUpdate: (_) {
            _dividerController.add(_);
          },
          onEnd: (index) async {
            context.read<SpinningStateCubit>().toggleSpin();
            context.read<SpinCubit>().setSpinState();
            context.read<SpinResultCubit>().getReward(index);
            _dividerController.add(index);
          },
          shouldStartOrStop: _wheelNotifier.stream,
          stopSpin: true,
        ),
        Align(
          alignment: Alignment.center,
          child: BlocBuilder<SpinCubit, String?>(
            builder: (context, spinState) {
              return Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
                child: InkWell(
                  child: MaterialButton(
                    padding: EdgeInsets.all(35.sp),
                    color: pinkColor,
                    disabledColor: pinkColor,
                    shape: const CircleBorder(),
                    onPressed: spinState == null ? () => _spinWheel() : null,
                    child: Builder(builder: (context) {
                      if (spinState == null) {
                        return const Text('Tap to spin');
                      } else {
                        return const Text('You get...');
                      }
                    }),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _spinWheel() {
    context.read<SpinningStateCubit>().toggleSpin();
    context.read<SpinResultCubit>().nullify();
    context.read<SpinCubit>().setSpinState();
    _wheelNotifier.sink.add(_generateRandomVelocity());
  }

  double _generateRandomVelocity() => (Random().nextDouble() * 6000) + 6000;
}
