import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' hide Chip;
import 'package:gg_poker/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'betting_event.dart';
part 'betting_state.dart';

enum Chip {
  c10(value: 10, assetPath: 'assets/chips/chocolate.png'),
  c50(value: 50, assetPath: 'assets/chips/chocolate.png'),
  c100(value: 100, assetPath: 'assets/chips/chocolate.png'),
  c200(value: 200, assetPath: 'assets/chips/biscuit.png'),
  c500(value: 500, assetPath: 'assets/chips/biscuit.png');

  final int value;
  final String assetPath;

  const Chip({required this.value, required this.assetPath});
}

class BettingBloc extends Bloc<BettingEvent, List<Chip>> {
  BettingBloc() : super([]) {
    on<AddChipBettingEvent>((event, emit) {
      if (sufficientBalance(event.chip)) {
        emit([...state, event.chip]);
      }
    });
    on<PopChipBettingEvent>((event, emit) {
      final newState = List.of(state);
      newState.removeLast();
      emit(newState);
    });
    on<AllInBettingEvent>((event, emit) {
      List<Chip> availableChips = List.of(Chip.values);
      availableChips.sort((a, b) => b.value.compareTo(a.value));

      List<Chip> selectedChips = [];
      int remainingBalance = locator<SharedPreferences>().getInt('coins')!;

      for (Chip chip in availableChips) {
        while (chip.value <= remainingBalance) {
          selectedChips.add(chip);
          remainingBalance -= chip.value;
        }
      }
      emit(selectedChips);
    });
    on<ClearBettingEvent>((event, emit) => emit([]));
  }

  int sumOfChips() =>
      state.fold(0, (previousValue, chip) => previousValue + chip.value);

  bool sufficientBalance(Chip chip) {
    int sum = sumOfChips();
    return sum + chip.value <=
        locator<SharedPreferences>().getInt('coins')!.toInt();
  }
}
