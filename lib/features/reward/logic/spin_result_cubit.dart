import 'package:bloc/bloc.dart';
import 'package:gg_poker/features/balance/balance_cubit.dart';
import 'package:gg_poker/features/reward/logic/rewards.dart';

class SpinResultCubit extends Cubit<Reward?> {
  final BalanceCubit balanceCubit;

  SpinResultCubit({required this.balanceCubit}) : super(null);

  getReward(int index) {
    balanceCubit.updateBalance(Reward.values[index - 1].value);
    emit(Reward.values[index - 1]);
  }

  nullify() => emit(null);
}
