// import 'package:auto_route/auto_route.dart';
// import 'package:fluent_ui/fluent_ui.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:formz/formz.dart';
// import 'package:loader_overlay/loader_overlay.dart';

// import '../../../../../data/models/models.dart';
// import '../../../../../data/repositories/repos.dart';
// import '../../../../../global_blocs/blocs.dart';
// import '../../../../widgets/custom_dialog.dart';
// import 'bloc/bloc.dart';
// import 'form_body.dart';

// class SystemUserUpdateFormPage extends StatelessWidget {
//   const SystemUserUpdateFormPage({
//     Key? key,
//     this.selectedSystemUser,
//   }) : super(key: key);

//   final SystemUserModel? selectedSystemUser;
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => SystemUserFormBloc(
//         systemUserRepo: context.read<SystemUserRepo>(),
//       ),
//       child: BlocListener<SystemUserFormBloc, SystemUserFormState>(
//         listenWhen: (previous, current) =>
//             current.status.isSubmissionFailure ||
//             current.status.isSubmissionInProgress ||
//             current.status.isSubmissionSuccess,
//         listener: (context, state) {
//           if (state.status.isSubmissionInProgress) {
//             context.loaderOverlay.show();
//           } else if (state.status.isSubmissionFailure) {
//             context.loaderOverlay.hide();
//             CustomDialogBox.errorMessage(context, message: state.message);
//           } else if (state.status.isSubmissionSuccess) {
//             context.loaderOverlay.hide();
//             CustomDialogBox.successMessage(
//               context,
//               message: state.message,
//               onPositiveClick: (_) {
//                 context.read<SystemUsersBloc>().add(LoadSystemUsers());
//                 context.router.pop();
//               },
//             );
//           }
//         },
//         child: ScaffoldPage.withPadding(
//           header: PageHeader(
//             leading: CommandBar(
//               overflowBehavior: CommandBarOverflowBehavior.noWrap,
//               primaryItems: [
//                 CommandBarBuilderItem(
//                   builder: (context, mode, w) => w,
//                   wrappedItem: CommandBarButton(
//                     icon: const Icon(
//                       FluentIcons.back,
//                     ),
//                     onPressed: () {
//                       context.router.pop();
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             title: const Text("System User Update Form"),
//           ),
//           content: SingleChildScrollView(
//             child: SystemUserFormBody(
//               selectedSystemUser: selectedSystemUser,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
