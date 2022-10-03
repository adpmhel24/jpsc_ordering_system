import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:localization/localization.dart';
import 'package:mobile_app/src/data/repositories/app_repo_providers.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'src/data/repositories/repos.dart';
import 'src/global_bloc/bloc_auth/bloc.dart';
import 'src/router/router.gr.dart';
import 'src/router/router_guard.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageRepo().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainApp(),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Locale? _locale;
  final AppRouter _appRouter = AppRouter(routeGuard: RouteGuard());

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
    return ChangeNotifierProvider(
        create: (_) => AppTheme(),
        builder: (context, _) {
          final appTheme = context.watch<AppTheme>();
          return MultiRepositoryProvider(
            providers: AppRepoProvider.repoProviders,
            child: BlocProvider(
              create: (context) => AuthBloc(),
              child: GlobalLoaderOverlay(
                child: MaterialApp.router(
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
                  themeMode: appTheme.mode,
                  color: appTheme.color,
                  darkTheme: ThemeData(
                    brightness: Brightness.dark,
                    colorScheme: const ColorScheme.dark(),
                    visualDensity: VisualDensity.standard,
                    elevatedButtonTheme: elevatedButtonTheme(),
                  ),
                  theme: ThemeData(
                      elevatedButtonTheme: elevatedButtonTheme(),
                      brightness: Brightness.light,
                      colorScheme: const ColorScheme.light(),
                      visualDensity: VisualDensity.standard,
                      appBarTheme: const AppBarTheme(
                          backgroundColor: Colors.lightGreen)),
                  builder: (_, child) {
                    return ResponsiveWrapper.builder(
                      BouncingScrollWrapper.builder(context, child!),
                      maxWidth: maxWidth,
                      minWidth: minWidth,
                      defaultScale: defaultScale,
                      breakpoints: breakpoints,
                    );
                  },
                  routeInformationParser: _appRouter.defaultRouteParser(),
                  routerDelegate: _appRouter.delegate(),
                ),
              ),
            ),
          );
        });
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
      primary: const Color(0xFFb1c795),
      onPrimary: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10),
    ),
  );
}
