import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gg_poker/features/balance/balance_cubit.dart';
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
      toolbarHeight: 56.h,
      leading: leading,
      title: SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          child: SvgPicture.asset('assets/main/logo_w_title.svg')),
      centerTitle: false,
      actions: [
        CustomContainer(
          child: BlocBuilder<BalanceCubit, int>(
            builder: (context, state) {
              return Row(
                children: [
                  Image.asset(
                    'assets/chips/biscuit.png',
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    state.toString(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(width: 20),
        IconButton(
          padding: padding,
          icon: Image.asset('assets/icons/person.png'),
          onPressed: () =>
              context.read<DialogBloc>().add(ProfileEvent(context: context)),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}
