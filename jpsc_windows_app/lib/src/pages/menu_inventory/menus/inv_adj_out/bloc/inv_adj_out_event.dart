part of 'inv_adj_out_bloc.dart';

abstract class InvAdjustmentOutBlocEvents extends Equatable {
  const InvAdjustmentOutBlocEvents();
  @override
  List<Object?> get props => [];
}

class RefreshInvAdjOut extends InvAdjustmentOutBlocEvents {}

class FilterInvAdjOut extends InvAdjustmentOutBlocEvents {
  final String? docStatus;
  final String? fromDate;
  final String? toDate;

  const FilterInvAdjOut({this.docStatus, this.fromDate, this.toDate});
  @override
  List<Object?> get props => [docStatus];
}

class CancelInAdjOut extends InvAdjustmentOutBlocEvents {
  final int id;
  final String canceledRemarks;

  const CancelInAdjOut({required this.id, required this.canceledRemarks});
  @override
  List<Object> get props => [id, canceledRemarks];
}
