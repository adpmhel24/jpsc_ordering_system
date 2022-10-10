// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../../data/repositories/repos.dart';
// import '../../../../utils/constant.dart';

// import '../../../../widgets/custom_animated_dialog.dart';
// import '../../../../widgets/custom_text_field.dart';
// import '../../../../widgets/ph_location_modal_widgets/brgy_modal_selection.dart';
// import '../../../../widgets/ph_location_modal_widgets/city_municipality_modal_selection.dart';

// class UpdateCustomerAddress extends StatefulWidget {
//   const UpdateCustomerAddress({
//     Key? key,
//     required this.customerId,
//   }) : super(key: key);

//   final int customerId;

//   @override
//   State<UpdateCustomerAddress> createState() => _UpdateCustomerAddressState();
// }

// class _UpdateCustomerAddressState extends State<UpdateCustomerAddress> {
//   final TextEditingController _custAddressController = TextEditingController();
//   final TextEditingController _brgyController = TextEditingController();
//   final TextEditingController _cityMunicipalityController =
//       TextEditingController();
//   final TextEditingController _otherDetailsController = TextEditingController();
//   final TextEditingController _deliveryFeeController = TextEditingController();

//   @override
//   void dispose() {
//     _custAddressController.dispose();
//     _brgyController.dispose();
//     _cityMunicipalityController.dispose();
//     _otherDetailsController.dispose();
//     _deliveryFeeController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     PhLocationRepo phLocationRepo = context.read<PhLocationRepo>();
//     return SafeArea(
//       child: Padding(
//         padding: EdgeInsets.only(
//             left: 10,
//             right: 10,
//             bottom: MediaQuery.of(context).viewInsets.bottom),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Constant.heightSpacer,
//               cityMunicipalityModalSelection(
//                 context: context,
//                 phLocationRepo: phLocationRepo,
//                 labelText: 'City / Municipality',
//                 cityMunicipalityController: _cityMunicipalityController,
//                 onChanged: (_) {},
//                 suffixIcon: IconButton(
//                   onPressed: () {
//                     _cityMunicipalityController.clear();
//                   },
//                   icon: const Icon(Icons.close),
//                 ),
//               ),
//               Constant.heightSpacer,
//               brgyModalSelection(
//                 context: context,
//                 labelText: 'Barangay',
//                 brgyController: _brgyController,
//                 phLocationRepo: phLocationRepo,
//                 onChanged: (value) {},
//                 suffixIcon: IconButton(
//                   onPressed: () {
//                     _brgyController.clear();
//                   },
//                   icon: const Icon(Icons.close),
//                 ),
//               ),
//               Constant.heightSpacer,
//               CustomTextField(
//                 autovalidateMode: AutovalidateMode.always,
//                 textInputAction: TextInputAction.newline,
//                 minLines: 3,
//                 maxLines: 6,
//                 controller: _custAddressController,
//                 labelText: 'Street Address*',
//                 prefixIcon: const Icon(Icons.home),
//                 onChanged: (value) {},
//                 suffixIcon: IconButton(
//                   onPressed: () {
//                     _custAddressController.clear();
//                   },
//                   icon: const Icon(Icons.close),
//                 ),
//                 validator: (_) {
//                   return null;
//                 },
//               ),
//               Constant.heightSpacer,
//               CustomTextField(
//                 textInputAction: TextInputAction.newline,
//                 minLines: 3,
//                 maxLines: 6,
//                 controller: _otherDetailsController,
//                 labelText: 'Other Details',
//                 prefixIcon: const Icon(Icons.details),
//                 onChanged: (_) {},
//                 suffixIcon: IconButton(
//                   onPressed: () {
//                     _otherDetailsController.clear();
//                   },
//                   icon: const Icon(Icons.close),
//                 ),
//               ),
//               Constant.heightSpacer,
//               ElevatedButton(
//                 onPressed: () {
//                   CustomAnimatedDialog.warning(
//                     cntx: context,
//                     message:
//                         "Are you sure you want to add new address details?",
//                     onPositiveClick: (cntx) async {
//                       Navigator.of(context).pop();
//                     },
//                   );
//                 },
//                 child: const Text('Add Address'),
//               ),
//               Constant.heightSpacer,
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
