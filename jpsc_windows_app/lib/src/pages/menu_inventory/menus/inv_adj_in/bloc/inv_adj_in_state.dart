part of 'inv_adj_in_bloc.dart';

class InvAdjustmentInBlocStates extends Equatable {
  final FetchingStatus status;
  final List<InventoryAdjustmentInModel> datas;
  final bool isCanceled;
  final String docstatus;
  final String fromDate;
  final String toDate;
  final String message;

  const InvAdjustmentInBlocStates({
    this.status = FetchingStatus.init,
    this.docstatus = DocStatus.closed,
    this.isCanceled = false,
    this.fromDate = "",
    this.toDate = "",
    this.datas = const [],
    this.message = "",
  });

  InvAdjustmentInBlocStates copyWith({
    FetchingStatus? status,
    List<InventoryAdjustmentInModel>? datas,
    bool? isCanceled,
    String? docstatus,
    String? fromDate,
    String? toDate,
    String? message,
  }) {
    return InvAdjustmentInBlocStates(
      status: status ?? this.status,
      datas: datas ?? this.datas,
      isCanceled: isCanceled ?? this.isCanceled,
      docstatus: docstatus ?? this.docstatus,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        status,
        datas,
        isCanceled,
        docstatus,
        fromDate,
        toDate,
        message,
      ];
}
