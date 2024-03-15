import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:gg_poker/init/firebase_options.dart';
import 'package:gg_poker/main.dart';

Future<void> initFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 25),
    minimumFetchInterval: const Duration(seconds: 25),
  ));
  await remoteConfig.fetchAndActivate();

  privacyPolicy = remoteConfig.getString("privacy_policy");
  termsOfUse = remoteConfig.getString("terms_of_use");
  promotion = remoteConfig.getString("promotion");
}
