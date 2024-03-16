import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide Dialog;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gg_poker/features/audio/audio_bloc.dart';
import 'package:gg_poker/features/dialog/ui/dialog.dart';
import 'package:gg_poker/features/dialog/ui/widgets/dialog_frame.dart';
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
          BlocBuilder<AudioBloc, AudioState>(
            builder: (context, state) {
              if (state.isPlaying) {
                return CustomButton(
                    color: primaryRedColor,
                    title: 'Turn off music',
                    icon: const Icon(Icons.music_note_rounded),
                    onPressed: () =>
                        context.read<AudioBloc>().add(AudioEvent.pause));
              } else {
                return CustomButton(
                    color: secondaryButtonColor,
                    title: 'Turn on music',
                    icon: const Icon(Icons.music_note_rounded),
                    onPressed: () =>
                        context.read<AudioBloc>().add(AudioEvent.play));
              }
            },
          ),
          const SizedBox(height: 8),
          CustomButton(
              color: secondaryButtonColor,
              title: 'Terms of use',
              icon: const Icon(Icons.list_alt_outlined),
              onPressed: () {
                context.router.popForced();
                context.router.push(const TermsOfUseRoute());
              }),
          const SizedBox(height: 8),
          CustomButton(
              color: secondaryButtonColor,
              title: 'Privacy Policy',
              icon: const Icon(Icons.privacy_tip_outlined),
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
