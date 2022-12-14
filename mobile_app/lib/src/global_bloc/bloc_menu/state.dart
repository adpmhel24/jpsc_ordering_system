part of 'bloc.dart';

class DrawerMenuState extends Equatable {
  final String currentMenu;

  const DrawerMenuState({this.currentMenu = "Price Quotation"});

  DrawerMenuState copyWith({
    String? currentMenu,
  }) =>
      DrawerMenuState(currentMenu: currentMenu ?? this.currentMenu);

  @override
  List<Object?> get props => [currentMenu];
}
