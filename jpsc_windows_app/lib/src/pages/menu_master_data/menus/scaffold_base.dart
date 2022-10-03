import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../../../utils/constant.dart';

class BaseMasterDataScaffold extends StatelessWidget {
  const BaseMasterDataScaffold({
    Key? key,
    required this.title,
    this.onSearchChanged,
    this.onNewButton,
    this.onRefreshButton,
    this.child,
  }) : super(key: key);

  final String title;
  final void Function(String)? onSearchChanged;
  final void Function()? onNewButton;
  final void Function()? onRefreshButton;
  final Widget? child;

  PageHeader _header(BuildContext context) {
    return PageHeader(
      leading: CommandBar(
        overflowBehavior: CommandBarOverflowBehavior.noWrap,
        primaryItems: [
          CommandBarBuilderItem(
            builder: (context, mode, w) => w,
            wrappedItem: CommandBarButton(
              icon: const Icon(FluentIcons.back),
              onPressed: () {
                context.router.pop();
              },
            ),
          ),
        ],
      ),
      title: Text(title),
      commandBar: SizedBox(
        width: 240.0,
        child: TextBox(
          suffix: const Icon(FluentIcons.search),
          placeholder: 'Type to filter the table',
          onChanged: onSearchChanged,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
      header: _header(context),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CommandBarCard(
            child: CommandBar(
              overflowBehavior: CommandBarOverflowBehavior.clip,
              primaryItems: [
                CommandBarBuilderItem(
                  builder: (context, mode, w) => w,
                  wrappedItem: CommandBarButton(
                    icon: const Icon(FluentIcons.add),
                    label: const Text("New"),
                    onPressed: onNewButton,
                  ),
                ),
                CommandBarBuilderItem(
                  builder: (context, mode, w) => w,
                  wrappedItem: CommandBarButton(
                    icon: const Icon(FluentIcons.refresh),
                    label: const Text("Refresh"),
                    onPressed: onRefreshButton,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: Constant.minPadding,
          ),
          Expanded(child: child ?? const SizedBox())
        ],
      ),
    );
  }
}
