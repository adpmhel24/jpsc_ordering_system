// import 'package:auto_route/auto_route.dart';
// import '../data/repositories/repos.dart';
// import './router.gr.dart';

// class RouteGuard extends AutoRouteGuard {
//   CurrentUserRepo currUserRepo = CurrentUserRepo()..checkIfLoggedIn();
//   RouteGuard() {
//     currUserRepo.addListener(reevaluate);
    
//   }

//    @override
//   Future<bool> canNavigate(
//       List<PageRouteInfo> routes, StackRouter router) async {
//     // await Future.delayed(Duration(seconds: 2));
//     final context = router.navigatorKey.currentContext;
//     print(FirebaseAuth.instance.currentUser);
//     if (Provider.of<User>(context, listen: false) == null) {
//       print('first auth == null');
//       await router.root.push(LoginViewRoute(
//           isRedirect: true,
//           onResult: (loggedIn) {
//             if (loggedIn) {
//               print('first auth');
//               router.pushAll(routes);
//             }
//           }));
//       print('second auth == null');
//       return false;
//     }
//     print('auth check from outside');
//     return true;

//   @override
//   Future<void> onNavigation(
//       NavigationResolver resolver, StackRouter router) async {
//     if (await canNavigate(resolver.route)) {
//       // resolver.route.
//       resolver.next();
//     } else {
//       redirect(const LoginRoute(), resolver: resolver);
//     }
//   }

//   @override
//   Future<bool> canNavigate(RouteMatch route) async {
//     return currUserRepo.isAuthenticated;
//   }
// }


// import 'package:auto_route/auto_route.dart';

// class CheckIfBookExists extends AutoRouteGuard {
//   @override
//   void onNavigation(NavigationResolver resolver, StackRouter router) async {
//     final bookId = resolver.route.queryParams.get("bookId");
//     final book = checkIfBookExists(bookId);
//     if (book != null)
//       resolver.next(true); // book was found. proceed to the page
//     else
//     router.push(NotFoundRoute());
//   }
// }