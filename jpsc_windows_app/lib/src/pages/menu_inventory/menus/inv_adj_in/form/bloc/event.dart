part of 'bloc.dart';

abstract class InvAdjustmentInFormEvent extends Equatable {
  const InvAdjustmentInFormEvent();
  @override
  List<Object?> get props => [];
}

class RemarksChanged extends InvAdjustmentInFormEvent {
  final TextEditingController remarksController;

  const RemarksChanged(this.remarksController);
  @override
  List<Object> get props => [remarksController];
}

class BranchChanged extends InvAdjustmentInFormEvent {
  final String branch;

  const BranchChanged(this.branch);
  @override
  List<Object> get props => [branch];
}

class TransdateChanged extends InvAdjustmentInFormEvent {
  final String transdate;
  const TransdateChanged(this.transdate);
  @override
  List<Object> get props => [transdate];
}

class AddRowItem extends InvAdjustmentInFormEvent {
  final InventoryAdjustmentInRow rowItem;

  const AddRowItem(this.rowItem);
  @override
  List<Object> get props => [rowItem];
}

class UpdateRowItem extends InvAdjustmentInFormEvent {
  final InventoryAdjustmentInRow oldItem;
  final InventoryAdjustmentInRow newItem;

  const UpdateRowItem({required this.oldItem, required this.newItem});
  @override
  List<Object> get props => [oldItem, newItem];
}

class DeleteRowItem extends InvAdjustmentInFormEvent {
  final InventoryAdjustmentInRow rowItem;

  const DeleteRowItem(this.rowItem);
  @override
  List<Object> get props => [rowItem];
}

class NewInvAdjustmentInSubmitted extends InvAdjustmentInFormEvent {}
