import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:window_manager/window_manager.dart';

import '../../theme.dart';
import '../global_blocs/blocs.dart';
import '../router/router.gr.dart';
import '../shared/widgets/custom_button.dart';
import 'menu_items.dart';
import 'windows_button.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WindowListener {
  final _innerRouterKey = GlobalKey<AutoRouterState>();
  bool value = false;

  int index = 0;
  final viewKey = GlobalKey();

  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  final routes = [
    const DashboardRoute(),
    // const PurchasingMenuRoute(),
    const SalesMenuWrapperRoute(),
    // const InventoryWrapperRoute(),
    const MasterDataWrapperRoute(),
    const MyProfileRoute(),
  ];

  @override
  Widget build(BuildContext context) {
    final appTheme = context.watch<AppTheme>();
    return MultiBlocProvider(
      providers: GlobalBlocs.blocs(context),
      child: SafeArea(
        child: NavigationView(
          key: viewKey,
          appBar: NavigationAppBar(
            automaticallyImplyLeading: false,
            actions: [TargetPlatform.windows].contains(defaultTargetPlatform)
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [Spacer(), WindowButtons()],
                  )
                : null,
          ),
          pane: NavigationPane(
            selected: index,
            onChanged: (i) {
              setState(() => index = i);
              final router = context.innerRouterOf<StackRouter>(MainRoute.name);

              router!.popAndPush(
                routes[i],
              );
            },
            size: const NavigationPaneSize(
              openMinWidth: 250,
              openMaxWidth: 250,
            ),
            header: Container(
              height: kOneLineTileHeight,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Image.asset(
                "assets/images/logo.png",
                fit: BoxFit.cover,
              ),
            ),
            displayMode: PaneDisplayMode.auto,
            indicator: () {
              switch (appTheme.indicator) {
                case NavigationIndicators.end:
                  return const EndNavigationIndicator();
                case NavigationIndicators.sticky:
                default:
                  return const StickyNavigationIndicator();
              }
            }(),
            items: [
              ...AppMenu.menuItems,
            ],
            footerItems: [
              PaneItemSeparator(),
              PaneItem(
                body: const SizedBox.expand(),
                icon: const Icon(FluentIcons.account_management),
                title: const Text("My Account"),
              ),
              PaneItemAction(
                icon: const Icon(FluentIcons.sign_out),
                title: const Text('Sign Out'),
                onTap: () {
                  context.read<AuthBloc>().add(LogoutSubmitted());
                },
              ),
            ],
          ),
          paneBodyBuilder: (viewWidget) {
            return AutoRouter(
              key: _innerRouterKey,
            );
          },
        ),
      ),
    );
  }

  @override
  void onWindowClose() async {
    bool isPreventClose = await windowManager.isPreventClose();
    if (isPreventClose) {
      showDialog(
        context: context,
        builder: (_) {
          return ContentDialog(
            title: const Text('Confirm close'),
            content: const Text('Are you sure you want to close this window?'),
            actions: [
              CustomButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CustomFilledButton(
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.pop(context);
                  windowManager.destroy();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
