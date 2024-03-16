import 'package:gg_poker/main.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> initDI() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  // locator<SharedPreferences>().clear();
  if (locator<SharedPreferences>().getBool('isFirstTime') == null) {
    isFirstTime = true;
    locator<SharedPreferences>().setInt('coins', 1000);
  } else {
    isFirstTime = false;
  }

  final player = AudioPlayer();
  player.setAsset('assets/music.mp3');
  player.playerStateStream.listen((state) {
    if (state.processingState == ProcessingState.completed) {
      player.seek(Duration.zero);
      player.play();
    }
  });
  locator.registerLazySingleton<AudioPlayer>(() => player);
}
