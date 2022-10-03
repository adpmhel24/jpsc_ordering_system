part of 'bloc.dart';

class InvAdjustmentOutFormState extends Equatable {
  final FormzStatus status;
  final String? transdate;
  final FormzString remarks;
  final FormzString branch;
  final String? responseMessage;
  final List<InventoryAdjustmentOutRow> itemRows;

  const InvAdjustmentOutFormState({
    this.status = FormzStatus.pure,
    this.transdate,
    this.remarks = const FormzString.pure(),
    this.branch = const FormzString.pure(),
    this.responseMessage,
    this.itemRows = const [],
  });

  InvAdjustmentOutFormState copyWith({
    FormzStatus? status,
    String? transdate,
    FormzString? remarks,
    FormzString? branch,
    String? responseMessage,
    List<InventoryAdjustmentOutRow>? itemRows,
  }) {
    return InvAdjustmentOutFormState(
      status: status ?? this.status,
      transdate: transdate ?? this.transdate,
      remarks: remarks ?? this.remarks,
      branch: branch ?? this.branch,
      responseMessage: responseMessage ?? this.responseMessage,
      itemRows: itemRows ?? this.itemRows,
    );
  }

  @override
  List<Object?> get props => [
        status,
        transdate,
        remarks,
        branch,
        responseMessage,
        itemRows,
      ];
}
