import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

class DrawerMenuBloc extends Bloc<DrawerMenuEvent, DrawerMenuState> {
  DrawerMenuBloc() : super(const DrawerMenuState()) {
    on<DrawerMenuClicked>(_onDrawerMenuClicked);
  }

  void _onDrawerMenuClicked(
      DrawerMenuClicked event, Emitter<DrawerMenuState> emit) {
    emit(state.copyWith(currentMenu: event.value));
  }
}
