import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide Dialog;
import 'package:gg_poker/features/dialog/ui/dialog.dart';
import 'package:gg_poker/features/dialog/ui/widgets/dialog_frame.dart';
import 'package:gg_poker/main.dart';
import 'package:gg_poker/theme/const.dart';
import 'package:gg_poker/theme/widgets/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DialogFirstTime extends Dialog {
  void showDialog(BuildContext context) {
    Widget widget = DialogFrame(
      child: Column(
        children: [
          const SizedBox(height: 24),
          Text(
            'Dear user!',
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: yellowColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 29),
          Text(
            '''
Our application invites you to try yourself in a unique game!
      
We are not involved in gambling, our application is absolutely free and offers you only entertainment.
      
Be careful and don't fall for a scam.
      
With love, developer.
      ''',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 29),
          CustomButton(
              color: primaryRedColor,
              title: 'Okay!',
              onPressed: () {
                locator<SharedPreferences>().setBool('isFirstTime', false);
                context.router.popForced();
              }),
        ],
      ),
    );
    build(context, widget, false, Colors.black87);
  }
}
