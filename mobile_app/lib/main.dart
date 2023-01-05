import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:localization/localization.dart';
import 'package:mobile_app/src/data/repositories/app_repo_providers.dart';
import 'package:responsive_framework/responsive_framework.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

import 'src/data/repositories/repos.dart';
import 'src/global_bloc/bloc_auth/bloc.dart';
import 'src/global_bloc/bloc_check_app_version/bloc.dart';
import 'src/router/router.gr.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageRepo().init();
  // runZonedGuarded(() {
  //   runApp(const MainApp());
  // }, (error, stackTrace) {
  //   print("Error FROM OUT_SIDE FRAMEWORK ");
  //   print("--------------------------------");
  //   print("Error :  $error");
  //   print("StackTrace :  $stackTrace");
  // });
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Locale? _locale;
  final AppRouter _appRouter = AppRouter();

  changeLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    LocalJsonLocalization.delegate.directories = ['assets/lang'];

    super.initState();
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
    return MultiRepositoryProvider(
      providers: AppRepoProvider.repoProviders,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (cntx) => CheckAppVersionBloc(
              cntx.read<AppVersionRepo>(),
            )..add(CheckingNewVersion()),
          ),
          BlocProvider(
            create: (cntx) => AuthBloc(cntx.read<CheckAppVersionBloc>()),
          ),
        ],
        child: Builder(builder: (context) {
          return GlobalLoaderOverlay(
            child: MaterialApp.router(
              themeMode: ThemeMode.system,
              title: "JPSC Ordering App",
              debugShowCheckedModeBanner: false,
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

                return const Locale('en', 'US');
              },
              supportedLocales: const [
                Locale('en', 'US'),
              ],
              theme: ThemeData.light().copyWith(
                appBarTheme:
                    const AppBarTheme(backgroundColor: Colors.lightGreen),
                visualDensity: VisualDensity.standard,
                colorScheme: const ColorScheme.light(),
                elevatedButtonTheme: elevatedButtonTheme(),
              ),
              darkTheme: ThemeData.dark().copyWith(
                brightness: Brightness.dark,
                colorScheme: const ColorScheme.dark(),
                visualDensity: VisualDensity.standard,
                elevatedButtonTheme: elevatedButtonTheme(),
              ),
              builder: (_, child) {
                return ResponsiveWrapper.builder(
                  BouncingScrollWrapper.builder(context, child!),
                  maxWidth: maxWidth,
                  minWidth: minWidth,
                  defaultScale: defaultScale,
                  breakpoints: breakpoints,
                );
              },
              routeInformationParser: _appRouter.defaultRouteParser(
                includePrefixMatches: true,
              ),
              routerDelegate:
                  AutoRouterDelegate.declarative(_appRouter, routes: (r) {
                bool hasNewVersion =
                    context.watch<CheckAppVersionBloc>().state.status ==
                        AppVersionStatus.available;
                final authStatus = context.watch<AuthBloc>().state.status;

                return [
                  if (authStatus == AuthStateStatus.loggedIn && !hasNewVersion)
                    ...r.initialPendingRoutes ??
                        [const NavigationHandlerRoute()]
                  else if (hasNewVersion)
                    NewVersionScreenRoute(
                        activeVersion:
                            context.read<CheckAppVersionBloc>().state.data!)
                  else
                    const LoginScreenRoute()
                ];
              }),
            ),
          );
        }),
      ),
    );
  }
}

elevatedButtonTheme() {
  return ElevatedButtonThemeData(
    // style: ButtonStyle(
    //   backgroundColor: MaterialStateProperty.all(const Color(0xFFb1c795)),
    //   foregroundColor: MaterialStateProperty.all(Colors.white),
    //   padding: MaterialStateProperty.all(
    //     EdgeInsets.symmetric(vertical: 14.h),
    //   ),
    // ),
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFb1c795),
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10),
    ),
  );
}
