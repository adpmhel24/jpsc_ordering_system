import 'package:auto_route/auto_route.dart';
import '../data/repositories/repos.dart';
import './router.gr.dart';

class RouteGuard extends AutoRedirectGuard {
  AuthRepo authRepo = AuthRepo()..checkIfLoggedIn();
  RouteGuard() {
    authRepo.addListener(reevaluate);
  }

  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    if (await canNavigate(resolver.route)) {
      resolver.next();
    } else {
      redirect(const LoginRoute(), resolver: resolver);
    }
  }

  @override
  Future<bool> canNavigate(RouteMatch route) async {
    return authRepo.isAuthenticated;
  }
}
