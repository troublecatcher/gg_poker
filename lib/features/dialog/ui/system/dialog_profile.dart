import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide Dialog;
import 'package:gg_poker/features/dialog/ui/dialog.dart';
import 'package:gg_poker/features/dialog/widgets/dialog_frame.dart';
import 'package:gg_poker/router/router.dart';
import 'package:gg_poker/theme/const.dart';
import 'package:gg_poker/theme/widgets/custom_button.dart';

class DialogProfile extends Dialog {
  void showDialog(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    Widget widget = DialogFrame(
      child: Column(
        children: [
          Image.asset(
            'assets/icons/person.png',
            width: width / 4,
            height: height / 4,
          ),
          CustomButton(
              color: primaryRedColor,
              children: const [
                Icon(Icons.music_note_rounded),
                Text('Music AW'),
              ],
              onPressed: () {}),
          const SizedBox(height: 8),
          CustomButton(
              color: secondaryButtonColor,
              children: const [
                Icon(Icons.list_alt_outlined),
                Text('Terms of use'),
              ],
              onPressed: () {
                context.router.popForced();
                context.router.push(const TermsOfUseRoute());
              }),
          const SizedBox(height: 8),
          CustomButton(
              color: secondaryButtonColor,
              children: const [
                Icon(Icons.privacy_tip_outlined),
                Text('Privacy Policy'),
              ],
              onPressed: () {
                context.router.popForced();
                context.router.push(const PrivacyPolicyRoute());
              }),
        ],
      ),
    );
    build(context, widget, true);
  }
}
