import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gg_poker/features/balance/balance_cubit.dart';
import 'package:gg_poker/features/reward/logic/rewards.dart';
import 'package:gg_poker/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpinCubit extends Cubit<String?> {
  late Timer timer;

  SpinCubit() : super('') {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      updateSpinState();
    });
  }

  updateSpinState() {
    String? coolDownString = locator<SharedPreferences>().getString('cooldown');
    if (coolDownString != null) {
      final coolDownDateTime =
          DateTime.fromMillisecondsSinceEpoch(int.parse(coolDownString));
      final now = DateTime.now();
      if (now.isBefore(coolDownDateTime)) {
        Duration difference = coolDownDateTime.difference(now);
        String formattedDifference =
            '${difference.inHours.remainder(24).toString().padLeft(2, '0')}:'
            '${difference.inMinutes.remainder(60).toString().padLeft(2, '0')}:'
            '${difference.inSeconds.remainder(60).toString().padLeft(2, '0')}';
        emit(formattedDifference);
      } else {
        emit(null);
      }
    } else {
      emit(null);
    }
  }

  setSpinState() {
    emit('');
    locator<SharedPreferences>().setString(
        'cooldown',
        DateTime.now()
            .add(const Duration(days: 1))
            .millisecondsSinceEpoch
            .toString());
  }

  free() {
    locator<SharedPreferences>().setString(
        'cooldown', DateTime.now().millisecondsSinceEpoch.toString());
  }
}
