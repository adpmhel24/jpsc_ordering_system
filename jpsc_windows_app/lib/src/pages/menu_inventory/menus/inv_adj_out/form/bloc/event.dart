part of 'bloc.dart';

abstract class InvAdjustmentOutFormEvent extends Equatable {
  const InvAdjustmentOutFormEvent();
  @override
  List<Object?> get props => [];
}

class RemarksChanged extends InvAdjustmentOutFormEvent {
  final TextEditingController remarksController;

  const RemarksChanged(this.remarksController);
  @override
  List<Object> get props => [remarksController];
}

class BranchChanged extends InvAdjustmentOutFormEvent {
  final String branch;

  const BranchChanged(this.branch);
  @override
  List<Object> get props => [branch];
}

class TransdateChanged extends InvAdjustmentOutFormEvent {
  final String transdate;
  const TransdateChanged(this.transdate);
  @override
  List<Object> get props => [transdate];
}

class AddRowItem extends InvAdjustmentOutFormEvent {
  final InventoryAdjustmentOutRow rowItem;

  const AddRowItem(this.rowItem);
  @override
  List<Object> get props => [rowItem];
}

class UpdateRowItem extends InvAdjustmentOutFormEvent {
  final InventoryAdjustmentOutRow oldItem;
  final InventoryAdjustmentOutRow newItem;

  const UpdateRowItem({required this.oldItem, required this.newItem});
  @override
  List<Object> get props => [oldItem, newItem];
}

class DeleteRowItem extends InvAdjustmentOutFormEvent {
  final InventoryAdjustmentOutRow rowItem;

  const DeleteRowItem(this.rowItem);
  @override
  List<Object> get props => [rowItem];
}

class NewInvAdjustmentOutSubmitted extends InvAdjustmentOutFormEvent {}
