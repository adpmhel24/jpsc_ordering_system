import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../global_blocs/main_nav_bloc/bloc.dart';

class ReportMainWrapper extends StatefulWidget {
  const ReportMainWrapper({Key? key}) : super(key: key);

  static const routeName = 'ReportMainWrapperPage';

  @override
  State<ReportMainWrapper> createState() => _ReportMainWrapperState();
}

class _ReportMainWrapperState extends State<ReportMainWrapper>
    with AutoRouteAwareStateMixin<ReportMainWrapper> {
  final _innerRouterKey = GlobalKey<AutoRouterState>();

  @override
  void didPush() {
    context.read<NavMenuCubit>().currentMenu(ReportMainWrapper.routeName);
    super.didPush();
  }

  @override
  Widget build(BuildContext context) {
    return AutoRouter(
      key: _innerRouterKey,
    );
  }
}
