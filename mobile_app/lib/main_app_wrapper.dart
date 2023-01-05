import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'src/global_bloc/bloc_auth/bloc.dart';
import 'src/global_bloc/bloc_check_app_version/bloc.dart';
import 'src/screens/utils/fetching_status.dart';
import 'src/screens/widgets/custom_animated_dialog.dart';

class MainContentWrapper extends StatelessWidget {
  const MainContentWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CheckAppVersionBloc, CheckAppVersionState>(
          listener: (cntx, state) {
            if (state.status == FetchingStatus.loading) {
              cntx.loaderOverlay.show();
            } else if (state.status == FetchingStatus.error) {
              CustomAnimatedDialog.error(cntx, message: state.message);
            } else if (state.status == FetchingStatus.success) {
              context.loaderOverlay.hide();
            }
          },
        ),
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStateStatus.loading) {
              context.loaderOverlay.show();
            } else if (state.status == AuthStateStatus.error) {
              CustomAnimatedDialog.error(context, message: state.message);
            } else if (state.status == AuthStateStatus.loggedIn ||
                state.status == AuthStateStatus.loggedOut) {
              context.loaderOverlay.hide();
            }
          },
        ),
      ],
      child: const AutoRouter(
        key: GlobalObjectKey("main_router"),
      ),
    );
  }
}
