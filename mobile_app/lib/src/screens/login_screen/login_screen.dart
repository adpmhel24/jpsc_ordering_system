import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../global_bloc/bloc_auth/bloc.dart';
import '../widgets/custom_animated_dialog.dart';
import 'bloc/login_bloc.dart';

import 'components/login_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginFormBloc(),
        ),
      ],
      child: Builder(
        builder: (BuildContext builderContext) {
          return BlocListener<AuthBloc, AuthState>(
            bloc: context.read<AuthBloc>(),
            listener: (context, state) {
              if (state.status == AuthStateStatus.loading) {
                context.loaderOverlay.show();
              } else if (state.status == AuthStateStatus.error) {
                CustomAnimatedDialog.error(context, message: state.message);
              } else if (state.status == AuthStateStatus.loggedIn) {
                context.loaderOverlay.hide();
              }
            },
            child: const LoginBody(),
          );
        },
      ),
      // child: const LoginBody(),
    );
  }
}
