import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
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
      appBar: CustomAppBar(width: size.width),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.7,
              child: const Stack(
                children: [
                  Align(
                      alignment: Alignment.topCenter,
                      child: WheelStatusWidget()),
                  Align(alignment: Alignment.center, child: Wheel()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
