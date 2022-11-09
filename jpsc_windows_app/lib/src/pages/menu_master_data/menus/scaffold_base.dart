import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../../../utils/constant.dart';

class BaseMasterDataScaffold extends StatelessWidget {
  const BaseMasterDataScaffold({
    Key? key,
    required this.title,
    required this.onSearchChanged,
    required this.onNewButton,
    required this.onRefreshButton,
    this.child,
    this.onAttachButton,
  }) : super(key: key);

  final String title;
  final void Function(BuildContext, String) onSearchChanged;
  final void Function(BuildContext) onNewButton;
  final void Function(BuildContext) onRefreshButton;
  final void Function(BuildContext context)? onAttachButton;
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
          onChanged: (value) => onSearchChanged(context, value),
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
                    onPressed: () => onNewButton(context),
                  ),
                ),
                CommandBarBuilderItem(
                  builder: (context, mode, w) => w,
                  wrappedItem: CommandBarButton(
                    icon: const Icon(FluentIcons.refresh),
                    label: const Text("Refresh"),
                    onPressed: () => onRefreshButton(context),
                  ),
                ),
                CommandBarBuilderItem(
                  builder: (context, mode, w) => w,
                  wrappedItem: CommandBarButton(
                    icon: const Icon(FluentIcons.attach),
                    label: const Text("Bulk Insert"),
                    onPressed: () {
                      if (onAttachButton != null) {
                        onAttachButton!(context);
                      }
                    },
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
