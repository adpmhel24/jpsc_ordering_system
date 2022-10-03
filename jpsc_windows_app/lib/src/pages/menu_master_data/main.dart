import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';

class MasterDataWrapperPage extends StatelessWidget {
  const MasterDataWrapperPage({Key? key}) : super(key: key);
  // final _innerRouterKey = GlobalKey<AutoRouterState>();

  @override
  Widget build(BuildContext context) {
    return const AutoRouter(
      key: GlobalObjectKey("master_data"),
    );
  }
}
