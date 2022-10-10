part of 'bloc.dart';

abstract class DrawerMenuEvent extends Equatable {
  const DrawerMenuEvent();
  @override
  List<Object?> get props => [];
}

class DrawerMenuClicked extends DrawerMenuEvent {
  final String value;

  const DrawerMenuClicked(this.value);

  @override
  List<Object?> get props => [value];
}
