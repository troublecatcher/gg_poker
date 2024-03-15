import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gg_poker/theme/const.dart';
import 'package:gg_poker/theme/widgets/custom_app_bar.dart';
import 'package:gg_poker/features/home/home_screen_item.dart';
import 'package:gg_poker/router/router.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(width: size.width),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 41),
            SizedBox(
              width: size.width * 0.9,
              height: size.height * 0.3,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: borderRadius,
                    child: Image.asset(
                      'assets/main/miniature.png',
                      fit: BoxFit.cover,
                      width: size.width * 0.9,
                      height: size.height * 0.3,
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: borderRadius,
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black],
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: padding,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            'assets/main/logo_w_title.svg',
                            width: size.width * 0.4,
                          ),
                          Text(
                            'Play for fun!',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            HomeScreenItem(
              assetPath: 'assets/main/cookie-monster.png',
              title: 'Easy Jack',
              buttonTitle: 'Play',
              onPressed: () => context.router.replace(const BlackjackRoute()),
            ),
            HomeScreenItem(
              assetPath: 'assets/main/chip-stack.png',
              title: 'Funny Wheel!',
              buttonTitle: 'Spin',
              onPressed: () => debugPrint('123'),
            ),
          ],
        ),
      ),
    );
  }
}
