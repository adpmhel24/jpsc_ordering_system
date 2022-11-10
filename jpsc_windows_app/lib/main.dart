import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:localization/localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:system_theme/system_theme.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:window_manager/window_manager.dart';

import 'src/data/repositories/app_repo_providers.dart';
import 'src/data/repositories/repos.dart';
import 'src/global_blocs/blocs.dart';
import 'src/global_blocs/main_nav_bloc/bloc.dart';
import 'src/router/router.gr.dart';
import 'src/router/router_guard.dart';
import 'theme.dart';

/// Checks if the current environment is a desktop environment.
bool get isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageRepo().init();

  // if it's on the web, windows or android, load the accent color
  if (kIsWeb ||
      [TargetPlatform.windows, TargetPlatform.android]
          .contains(defaultTargetPlatform)) {
    SystemTheme.accentColor.load();
  }

  setPathUrlStrategy();

  if (isDesktop) {
    await flutter_acrylic.Window.initialize();
    await WindowManager.instance.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setTitleBarStyle(
        TitleBarStyle.hidden,
      );

      // await windowManager.setSize(const Size(755, 545));
      await windowManager.setSize(await windowManager.getSize());
      await windowManager.setMinimumSize(const Size(755, 545));
      await windowManager.center();
      await windowManager.show();
      await windowManager.setPreventClose(true);
      await windowManager.setSkipTaskbar(false);
    });
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouter _appRouter = AppRouter(routeGuard: RouteGuard());
  Locale? _locale;

  changeLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  final double maxWidth = 2460;
  final double minWidth = 450;
  final bool defaultScale = true;
  final breakpoints = const [
    ResponsiveBreakpoint.resize(450, name: MOBILE),
    ResponsiveBreakpoint.autoScale(800, name: TABLET),
    ResponsiveBreakpoint.autoScale(1000, name: TABLET),
    ResponsiveBreakpoint.resize(1200, name: DESKTOP),
    ResponsiveBreakpoint.autoScale(2460, name: "4K"),
  ];

  @override
  Widget build(BuildContext context) {
    LocalJsonLocalization.delegate.directories = ['assets/lang'];
    return MultiRepositoryProvider(
      providers: AppRepoProvider.repoProviders,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(),
          ),
          BlocProvider(
            create: (_) => NavMenuCubit(),
          )
        ],
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => AppTheme(),
            ),
            ChangeNotifierProvider(
              lazy: false,
              create: (_) => CurrentUserRepo()..checkIfLoggedIn(),
            )
          ],
          builder: (context, _) {
            final appTheme = context.watch<AppTheme>();
            return GlobalLoaderOverlay(
              useDefaultLoading: false,
              overlayWidget: const Center(
                child: SpinKitWave(
                  color: Colors.white,
                ),
              ),
              child: FluentApp.router(
                locale: _locale,
                localizationsDelegates: [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  LocalJsonLocalization.delegate,
                ],
                localeResolutionCallback: (locale, supportedLocales) {
                  if (supportedLocales.contains(locale)) {
                    return locale;
                  }

                  if (locale?.languageCode == 'en') {
                    return const Locale('en', 'US');
                  }
                  return const Locale('pt', 'BR');
                },
                supportedLocales: const [
                  Locale('pt', 'BR'),
                  Locale('en', 'US'),
                ],
                title: "ERP System",
                themeMode: appTheme.mode,
                debugShowCheckedModeBanner: false,
                color: appTheme.color,
                darkTheme: ThemeData(
                  brightness: Brightness.dark,
                  accentColor: appTheme.color,
                  visualDensity: VisualDensity.standard,
                  focusTheme: FocusThemeData(
                    glowFactor: is10footScreen() ? 2.0 : 0.0,
                  ),
                ),
                theme: ThemeData(
                  brightness: Brightness.light,
                  accentColor: appTheme.color,
                  visualDensity: VisualDensity.standard,
                  focusTheme: FocusThemeData(
                    glowFactor: is10footScreen() ? 2.0 : 0.0,
                  ),
                ),
                routerDelegate: AutoRouterDelegate(
                  _appRouter,
                  navigatorObservers: () => [AutoRouteObserver()],
                ),
                routeInformationParser: _appRouter.defaultRouteParser(),
                builder: (context, child) {
                  return ResponsiveWrapper.builder(
                    BouncingScrollWrapper.builder(context, child!),
                    maxWidth: maxWidth,
                    minWidth: minWidth,
                    defaultScale: defaultScale,
                    breakpoints: breakpoints,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
