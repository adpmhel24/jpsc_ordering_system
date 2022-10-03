part of 'inv_adj_in_bloc.dart';

abstract class InvAdjustmentInBlocEvents extends Equatable {
  const InvAdjustmentInBlocEvents();
  @override
  List<Object?> get props => [];
}

class RefreshInvAdjIn extends InvAdjustmentInBlocEvents {}

class FilterDateInvAdjIn extends InvAdjustmentInBlocEvents {
  final String fromDate;
  final String toDate;

  const FilterDateInvAdjIn(this.fromDate, this.toDate);

  @override
  List<Object> get props => [fromDate, toDate];
}

class FilterInvAdjIn extends InvAdjustmentInBlocEvents {
  final String? docStatus;
  final String? fromDate;
  final String? toDate;

  const FilterInvAdjIn({this.docStatus, this.fromDate, this.toDate});
  @override
  List<Object?> get props => [docStatus];
}

class CancelInAdjIn extends InvAdjustmentInBlocEvents {
  final int id;
  final String canceledRemarks;

  const CancelInAdjIn({required this.id, required this.canceledRemarks});
  @override
  List<Object> get props => [id, canceledRemarks];
}
