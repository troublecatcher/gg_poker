import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gg_poker/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'balance_state.dart';

class BalanceCubit extends Cubit<int> {
  BalanceCubit() : super(0) {
    fetchBalance();
  }

  fetchBalance() {
    emit(locator<SharedPreferences>().getInt('coins')!);
  }

  updateBalance(int value) {
    int balance = locator<SharedPreferences>().getInt('coins')!;
    int newBalance = balance += value;
    locator<SharedPreferences>().setInt('coins', newBalance);
    emit(newBalance);
  }
}
