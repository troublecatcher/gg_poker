import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gg_poker/features/reward/logic/spinning_state_cubit.dart';
import 'package:gg_poker/features/reward/ui/widgets/wheel.dart';
import 'package:gg_poker/features/reward/ui/widgets/wheel_status_widget.dart';
import 'package:gg_poker/theme/widgets/custom_app_bar.dart';

@RoutePage()
class RewardScreen extends StatelessWidget {
  const RewardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        width: size.width,
        leading: BlocBuilder<SpinningStateCubit, bool>(
          builder: (context, spinning) {
            if (spinning) {
              return const SizedBox.shrink();
            } else {
              return const BackButton();
            }
          },
        ),
      ),
      body: const Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WheelStatusWidget(),
              Wheel(),
            ],
          ),
        ],
      ),
    );
  }
}
