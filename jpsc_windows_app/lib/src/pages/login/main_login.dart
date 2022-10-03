import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../global_blocs/blocs.dart';
import '../widgets/custom_dialog.dart';
import 'bloc/bloc.dart';
import 'widgets/body.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStateStatus.loading) {
            context.loaderOverlay.show();
          } else if (state.status == AuthStateStatus.error) {
            context.loaderOverlay.hide();
            CustomDialogBox.errorMessage(context, message: state.message);
          } else if (state.status == AuthStateStatus.loggedIn ||
              state.status == AuthStateStatus.loggedOut) {
            context.loaderOverlay.hide();
          }
        },
        child: ScaffoldPage(
          content: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: const LoginBody(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
