import 'package:bloc/bloc.dart';

class SpinningStateCubit extends Cubit<bool> {
  SpinningStateCubit() : super(false);

  toggleSpin() => emit(!state);
}
