import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gg_poker/features/balance/balance_cubit.dart';
import 'package:gg_poker/features/blackjack/game/logic/game_bloc/game_bloc.dart';
import 'package:gg_poker/features/dialog/logic/dialog_bloc/bloc/dialog_bloc.dart';
import 'package:gg_poker/features/dialog/logic/dialog_manager_system.dart';
import 'package:gg_poker/theme/const.dart';
import 'package:gg_poker/theme/widgets/custom_container.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.width,
    this.leading,
  });

  final double width;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: SizedBox(
          width: width / 3,
          child: SvgPicture.asset('assets/main/logo_w_title.svg')),
      centerTitle: false,
      actions: [
        CustomContainer(
          child: BlocBuilder<BalanceCubit, int>(
            builder: (context, state) {
              return Text(state.toString());
            },
          ),
        ),
        const SizedBox(width: 20),
        BlocListener<DialogBloc, DialogState>(
          listener: (context, state) {
            DialogManagerSystem.showDialog(context, state);
          },
          child: IconButton(
            padding: padding,
            icon: Image.asset('assets/icons/person.png'),
            onPressed: () => context.read<DialogBloc>().add(ProfileEvent()),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
