import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:gg_poker/features/balance/balance_cubit.dart';
import 'package:gg_poker/features/blackjack/betting/logic/betting_cubit/betting_cubit.dart';
import 'package:gg_poker/features/blackjack/game/logic/game_bloc/game_bloc.dart';
import 'package:gg_poker/features/blackjack/game/logic/dealer_cubit/dealer_cubit.dart';
import 'package:gg_poker/features/blackjack/game/logic/deck_cubit/deck_cubit.dart';
import 'package:gg_poker/features/blackjack/game/logic/player_cubit/player_cubit.dart';
import 'package:gg_poker/features/dialog/logic/dialog_bloc/bloc/dialog_bloc.dart';
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
        BlocProvider(create: (context) => DialogBloc()),
        BlocProvider(create: (context) => BalanceCubit()),
        BlocProvider(create: (context) => BettingCubit()),
        BlocProvider(create: (context) => PlayerCubit()),
        BlocProvider(create: (context) => DealerCubit()),
        BlocProvider(create: (context) => DeckCubit()),
        BlocProvider(
            create: (context) => GameBloc(
                  player: context.read<PlayerCubit>(),
                  dealer: context.read<DealerCubit>(),
                  deck: context.read<DeckCubit>(),
                  bet: context.read<BettingCubit>(),
                  balance: context.read<BalanceCubit>(),
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
