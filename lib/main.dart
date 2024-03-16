import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:gg_poker/features/balance/balance_cubit.dart';
import 'package:gg_poker/features/blackjack/betting/logic/bloc/betting_bloc.dart';
import 'package:gg_poker/features/blackjack/game/logic/game_bloc/game_bloc.dart';
import 'package:gg_poker/features/blackjack/game/logic/entity/dealer/dealer_cubit.dart';
import 'package:gg_poker/features/blackjack/game/logic/entity/deck/deck_cubit.dart';
import 'package:gg_poker/features/blackjack/game/logic/entity/player/player_cubit.dart';
import 'package:gg_poker/features/dialog/logic/dialog_bloc/bloc/dialog_bloc.dart';
import 'package:gg_poker/features/reward/logic/spin_cubit.dart';
import 'package:gg_poker/features/reward/logic/spin_result_cubit.dart';
import 'package:gg_poker/init/init_firebase.dart';
import 'package:gg_poker/init/init_shared_preferences.dart';
import 'package:gg_poker/router/router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gg_poker/theme/theme.dart';

bool? isFirstTime;
String? privacyPolicy;
String? termsOfUse;
String? promotion;

final locator = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initFirebase();
  await initSharedPreferences();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BalanceCubit()),
        BlocProvider(create: (context) => SpinCubit()),
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
    return MaterialApp.router(
      theme: theme,
      routerConfig: _appRouter.config(),
      debugShowCheckedModeBanner: false,
    );
  }
}
