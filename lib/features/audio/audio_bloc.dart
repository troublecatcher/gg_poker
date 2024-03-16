import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gg_poker/main.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AudioEvent { play, pause }

class AudioState {
  final bool isPlaying;

  AudioState({required this.isPlaying});
}

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  final AudioPlayer player;
  bool audio;

  AudioBloc({required this.player, required this.audio})
      : super(AudioState(isPlaying: audio)) {
    on<AudioEvent>((event, emit) {
      if (event == AudioEvent.play) {
        player.play();
        emit(AudioState(isPlaying: true));
        locator<SharedPreferences>().setBool('audio', true);
      } else if (event == AudioEvent.pause) {
        player.pause();
        emit(AudioState(isPlaying: false));
        locator<SharedPreferences>().setBool('audio', false);
      }
    });
  }
}
