import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:gg_poker/features/audio/audio_bloc.dart';
import 'package:gg_poker/features/balance/balance_cubit.dart';
import 'package:gg_poker/features/blackjack/betting/logic/bloc/betting_bloc.dart';
import 'package:gg_poker/features/blackjack/game/logic/game_bloc/game_bloc.dart';
import 'package:gg_poker/features/blackjack/game/logic/entity/dealer/dealer_cubit.dart';
import 'package:gg_poker/features/blackjack/game/logic/entity/deck/deck_cubit.dart';
import 'package:gg_poker/features/blackjack/game/logic/entity/player/player_cubit.dart';
import 'package:gg_poker/features/dialog/logic/dialog_bloc/bloc/dialog_bloc.dart';
import 'package:gg_poker/features/dialog/logic/dialog_manager_system.dart';
import 'package:gg_poker/features/reward/logic/spin_cubit.dart';
import 'package:gg_poker/features/reward/logic/spin_result_cubit.dart';
import 'package:gg_poker/features/reward/logic/spinning_state_cubit.dart';
import 'package:gg_poker/init/init_firebase.dart';
import 'package:gg_poker/init/init_di.dart';
import 'package:gg_poker/router/router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gg_poker/theme/theme.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool? isFirstTime;
String? privacyPolicy;
String? termsOfUse;
String? promotion;

final locator = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initFirebase();
  await initDI();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  bool? audio = locator<SharedPreferences>().getBool('audio');
  if (audio != null) {
    if (audio) {
      locator<AudioPlayer>().play();
    }
  } else {
    locator<AudioPlayer>().play();
  }

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AudioBloc(
                player: locator<AudioPlayer>(), audio: audio ?? true)),
        BlocProvider(create: (context) => BalanceCubit()),
        BlocProvider(create: (context) => SpinCubit()),
        BlocProvider(create: (context) => SpinningStateCubit()),
        BlocProvider(
            create: (context) => SpinResultCubit(
                  balanceCubit: context.read<BalanceCubit>(),
                )),
        BlocProvider(create: (context) => DialogBloc()),
        BlocProvider(create: (context) => BettingBloc()),
        BlocProvider(create: (context) => PlayerCubit()),
        BlocProvider(create: (context) => DealerCubit()),
        BlocProvider(create: (context) => DeckCubit()),
        BlocProvider(
            create: (context) => GameBloc(
                  playerCubit: context.read<PlayerCubit>(),
                  dealerCubit: context.read<DealerCubit>(),
                  deckCubit: context.read<DeckCubit>(),
                  bettingBloc: context.read<BettingBloc>(),
                  balanceCubit: context.read<BalanceCubit>(),
                )),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp.router(
          theme: theme,
          routerConfig: _appRouter.config(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
