import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gg_poker/theme/const.dart';
import 'package:gg_poker/theme/widgets/custom_button.dart';

class HomeScreenItem extends StatelessWidget {
  const HomeScreenItem({
    super.key,
    required this.assetPath,
    required this.title,
    required this.buttonTitle,
    required this.onPressed,
  });

  final String assetPath;
  final String title;
  final String buttonTitle;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.2,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 21, horizontal: 23),
              constraints: BoxConstraints(
                maxWidth: size.width * 0.9,
                maxHeight: 150.h,
                minWidth: size.width * 0.9,
                minHeight: 150.h,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    secondaryRedColor,
                    Colors.black,
                  ],
                ),
                borderRadius: borderRadius,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    width: size.width * 0.33,
                    child: CustomButton(
                      color: yellowColor,
                      onPressed: onPressed,
                      title: buttonTitle,
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Image.asset(assetPath),
          )
        ],
      ),
    );
  }
}
