import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gg_poker/theme/const.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final Function()? onPressed;
  final String title;
  final Widget? icon;

  const CustomButton(
      {super.key,
      required this.color,
      this.onPressed,
      required this.title,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
            backgroundColor: color,
            foregroundColor: Colors.white,
            disabledBackgroundColor: disabledButtonColor,
            disabledForegroundColor: Colors.white,
            splashFactory: NoSplash.splashFactory,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            )),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: icon != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon!,
                    const SizedBox(width: 8),
                    Text(title),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title),
                  ],
                ),
        ));
  }
}
