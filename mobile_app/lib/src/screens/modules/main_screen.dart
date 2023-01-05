import 'package:auto_route/auto_route.dart';

import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/repos.dart';
import '../../global_bloc/bloc_menu/bloc.dart';
import '../../global_bloc/main_bloc_provider.dart';

import '../widgets/side_menu.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  // void initState() {
  //   context.read<CheckAppVersionBloc>().add(CheckingNewVersion());
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: MainScreenBlocProvider.blocs,
      child: BlocProvider(
        create: (context) => DrawerMenuBloc(),
        child: BlocBuilder<DrawerMenuBloc, DrawerMenuState>(
          builder: (_, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text(state.currentMenu),
              ),
              drawer: const SideMenu(),
              key: RepositoryProvider.of<MenuController>(context).scaffoldKey,
              body: const DoubleBackToCloseApp(
                snackBar: SnackBar(
                  content: Text('Tap back again to leave'),
                ),
                child: AutoRouter(
                  key: GlobalObjectKey("main_router"),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
