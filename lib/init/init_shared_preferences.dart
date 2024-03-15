import 'package:gg_poker/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  // locator<SharedPreferences>().clear();
  if (locator<SharedPreferences>().getBool('isFirstTime') == null) {
    isFirstTime = true;
    locator<SharedPreferences>().setInt('coins', 1000);
  }
  locator<SharedPreferences>().setBool('isFirstTime', false);
}
