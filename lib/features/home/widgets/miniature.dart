import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gg_poker/theme/const.dart';

class Miniature extends StatelessWidget {
  const Miniature({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
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
    );
  }
}
