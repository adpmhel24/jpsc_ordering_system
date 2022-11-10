import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../global_blocs/main_nav_bloc/bloc.dart';

class MasterDataMainWrapper extends StatefulWidget {
  const MasterDataMainWrapper({Key? key}) : super(key: key);

  static const routeName = 'MasterDataMainWrapperPage';

  @override
  State<MasterDataMainWrapper> createState() => _MasterDataMainWrapperState();
}

class _MasterDataMainWrapperState extends State<MasterDataMainWrapper>
    with AutoRouteAwareStateMixin<MasterDataMainWrapper> {
  final _innerRouterKey = GlobalKey<AutoRouterState>();
  @override
  void didPush() {
    context.read<NavMenuCubit>().currentMenu(MasterDataMainWrapper.routeName);
    super.didPush();
  }

  @override
  Widget build(BuildContext context) {
    return AutoRouter(
      key: _innerRouterKey,
    );
  }
}
