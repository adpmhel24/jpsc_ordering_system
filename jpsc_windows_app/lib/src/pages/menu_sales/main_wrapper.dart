import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../global_blocs/main_nav_bloc/bloc.dart';

class SalesMainWrapper extends StatefulWidget {
  const SalesMainWrapper({Key? key}) : super(key: key);

  static const routeName = 'SalesMainWrapperPage';

  @override
  State<SalesMainWrapper> createState() => _SalesMainWrapperState();
}

class _SalesMainWrapperState extends State<SalesMainWrapper>
    with AutoRouteAwareStateMixin<SalesMainWrapper> {
  final _innerRouterKey = GlobalKey<AutoRouterState>();

  @override
  void didPush() {
    context.read<NavMenuCubit>().currentMenu(SalesMainWrapper.routeName);
    super.didPush();
  }

  @override
  Widget build(BuildContext context) {
    return AutoRouter(
      key: _innerRouterKey,
    );
  }
}
