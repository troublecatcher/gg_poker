import 'package:auto_route/auto_route.dart';
import 'package:gg_poker/features/promotion/promotion_screen.dart';
import 'package:gg_poker/main.dart';

import '../features/blackjack/game/ui/layout/blackjack_screen.dart';
import '../features/home/screens/home_screen.dart';
import '../features/home/screens/privacy_policy_screen.dart';
import '../features/home/screens/terms_of_use_screen.dart';
import '../features/reward/ui/layout/reward_screen.dart';

part 'router.gr.dart';

final showPromotion = promotion != null && promotion != '';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(
            page: HomeRoute.page,
            initial: !showPromotion,
            transitionsBuilder: TransitionsBuilders.slideRight),
        AutoRoute(page: BlackjackRoute.page),
        AutoRoute(page: PromotionRoute.page, initial: showPromotion),
        AutoRoute(page: RewardRoute.page),
        AutoRoute(page: TermsOfUseRoute.page),
        AutoRoute(page: PrivacyPolicyRoute.page),
      ];
}
