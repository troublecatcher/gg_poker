import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gg_poker/features/dialog/ui/system/dialog_first_time.dart';
import 'package:gg_poker/features/home/widgets/miniature.dart';
import 'package:gg_poker/features/reward/logic/spin_cubit.dart';
import 'package:gg_poker/features/reward/logic/spin_result_cubit.dart';
import 'package:gg_poker/main.dart';
import 'package:gg_poker/theme/widgets/custom_app_bar.dart';
import 'package:gg_poker/features/home/widgets/home_screen_item.dart';
import 'package:gg_poker/router/router.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AfterLayoutMixin<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // context.read<SpinCubit>().free();
    // context
    //     .read<DialogBloc>()
    //     .stream
    //     .listen((state) => DialogManagerSystem.showDialog(context, state));
    return Scaffold(
      appBar: CustomAppBar(width: size.width),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 41),
            const Miniature(),
            const SizedBox(height: 20),
            HomeScreenItem(
              assetPath: 'assets/main/cookie-monster.png',
              title: 'Easy Jack',
              buttonTitle: 'Play',
              onPressed: () => context.router.replace(const BlackjackRoute()),
            ),
            BlocBuilder<SpinCubit, String?>(
              builder: (context, state) {
                return HomeScreenItem(
                  assetPath: 'assets/main/chip-stack.png',
                  title: 'Funny Wheel!',
                  buttonTitle: state ?? 'Spin',
                  onPressed: state == null
                      ? () {
                          context.read<SpinResultCubit>().nullify();
                          context.router.push(const RewardRoute());
                        }
                      : null,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    if (isFirstTime!) {
      DialogFirstTime().showDialog(context);
    }
  }
}
