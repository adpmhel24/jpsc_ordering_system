import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';

class MasterDataWrapperPage extends StatefulWidget {
  const MasterDataWrapperPage({Key? key}) : super(key: key);

  @override
  State<MasterDataWrapperPage> createState() => _MasterDataWrapperPageState();
}

class _MasterDataWrapperPageState extends State<MasterDataWrapperPage> {
  final _innerRouterKey = GlobalKey<AutoRouterState>();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AutoRouter(
      key: _innerRouterKey,
    );
  }
}
