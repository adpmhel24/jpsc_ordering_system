// import 'package:auto_route/auto_route.dart';
// import 'package:mobile_app/src/router/router.gr.dart';
// import '../data/repositories/repos.dart';

// class RouteGuard extends AutoRedirectGuard {
//   CurrentUserRepo currentUserRepo = CurrentUserRepo()..checkIfLoggedIn();
//   RouteGuard() {
//     currentUserRepo.addListener(reevaluate);
//   }

//   @override
//   Future<void> onNavigation(
//       NavigationResolver resolver, StackRouter router) async {
//     if (await canNavigate(resolver.route)) {
//       resolver.next();
//     } else {
//       redirect(const LoginScreenRoute(), resolver: resolver);
//     }
//   }

//   @override
//   Future<bool> canNavigate(RouteMatch route) async {
//     return currentUserRepo.isAuthenticated;
//   }
// }
