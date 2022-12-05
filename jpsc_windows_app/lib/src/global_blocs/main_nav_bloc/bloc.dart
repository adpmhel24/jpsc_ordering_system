import 'package:flutter_bloc/flutter_bloc.dart';

import '../../pages/dashboard/dashboard.dart';
import '../../pages/menu_master_data/main_wrapper.dart';
import '../../pages/menu_profile/my_profile_page.dart';
import '../../pages/menu_sales/main_wrapper.dart';

class NavMenuCubit extends Cubit<int> {
  NavMenuCubit() : super(0);

  static const List<String> _menus = [
    DashboardPage.routeName,
    SalesMainWrapper.routeName,
    MasterDataMainWrapper.routeName,
    // ReportMainWrapper.routeName,
    MyProfile.routeName,
  ];

  /// Add 1 to the current state.
  void currentMenu(String value) {
    int indx = _menus.indexWhere((element) => element == value);
    return emit(indx);
  }
}
