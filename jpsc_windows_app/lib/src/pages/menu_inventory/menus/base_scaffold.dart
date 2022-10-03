import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:intl/intl.dart';

import '../../../shared/enums/docstatus.dart';
import '../../../shared/widgets/custom_date_picker.dart';
import '../../../utils/constant.dart';
import '../../../utils/responsive.dart';

typedef BlocWidgetBuilder<S> = Widget Function(BuildContext context, S state);

class BaseInventoryScaffold extends StatefulWidget {
  const BaseInventoryScaffold({
    Key? key,
    required this.title,
    required this.tabs,
    required this.onFilter,
    this.onNewButton,
    this.onRefreshButton,
  }) : super(key: key);

  final String title;
  final Function(String fromDate, String toDate) onFilter;
  final void Function()? onNewButton;
  final void Function()? onRefreshButton;

  final List<Tab> tabs;

  @override
  State<BaseInventoryScaffold> createState() => _BaseInventoryScaffoldState();
}

class _BaseInventoryScaffoldState extends State<BaseInventoryScaffold> {
  final TextEditingController _searchBoxController = TextEditingController();
  String docstatus = DocStatus.closed;

  DateTime? fromDate = DateTime.now();
  DateTime? toDate = DateTime.now();
  int currentIndex = 0;
  DateFormat dateFormat = DateFormat('MM/dd/yyyy');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchBoxController.dispose();
    super.dispose();
  }

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
      title: Text(widget.title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
      header: _header(context),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flex(
            direction:
                Responsive.isMobile(context) ? Axis.vertical : Axis.horizontal,
            mainAxisSize: Responsive.isMobile(context)
                ? MainAxisSize.min
                : MainAxisSize.max,
            verticalDirection: VerticalDirection.up,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flex(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      direction: Responsive.isMobile(context)
                          ? Axis.vertical
                          : Axis.horizontal,
                      children: [
                        SizedBox(
                          width: 200,
                          child: TextBox(
                            header: "Search",
                            controller: _searchBoxController,
                            suffix: const Icon(FluentIcons.search),
                            placeholder: 'Type to filter the table',
                          ),
                        ),
                        if (!Responsive.isMobile(context)) const Spacer(),
                        CustomDatePicker(
                          label: "From Date",
                          date: fromDate,
                          dateFormat: dateFormat,
                          onChanged: (dateTime) {
                            setState(() {
                              fromDate = dateTime;
                            });
                          },
                        ),
                        const SizedBox(
                          height: Constant.minPadding,
                          width: Constant.minPadding,
                        ),
                        CustomDatePicker(
                          label: "To Date",
                          date: toDate,
                          dateFormat: dateFormat,
                          onChanged: (dateTime) {
                            setState(() {
                              toDate = dateTime;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: Constant.minPadding,
                    ),
                    Flexible(
                      child: CommandBarCard(
                        child: CommandBar(
                          overflowBehavior: CommandBarOverflowBehavior.clip,
                          primaryItems: [
                            CommandBarBuilderItem(
                              builder: (context, mode, w) => w,
                              wrappedItem: CommandBarButton(
                                icon: const Icon(FluentIcons.add),
                                label: const Text("New"),
                                onPressed: widget.onNewButton,
                              ),
                            ),
                            CommandBarBuilderItem(
                              builder: (context, mode, w) => w,
                              wrappedItem: CommandBarButton(
                                icon: const Icon(FluentIcons.refresh),
                                label: const Text("Refresh"),
                                onPressed: widget.onRefreshButton,
                              ),
                            ),
                            CommandBarBuilderItem(
                              builder: (context, mode, w) => w,
                              wrappedItem: CommandBarButton(
                                icon: const Icon(FluentIcons.filter),
                                label: const Text("Filter"),
                                onPressed: () {
                                  widget.onFilter(dateFormat.format(fromDate!),
                                      dateFormat.format(toDate!));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: Constant.minPadding,
              ),
            ],
          ),
          const SizedBox(
            height: Constant.minPadding,
          ),
          Expanded(
            child: TabView(
              tabWidthBehavior: TabWidthBehavior.sizeToContent,
              currentIndex: currentIndex,
              closeButtonVisibility: CloseButtonVisibilityMode.never,
              onChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              tabs: widget.tabs,
            ),
          )
        ],
      ),
    );
  }
}
