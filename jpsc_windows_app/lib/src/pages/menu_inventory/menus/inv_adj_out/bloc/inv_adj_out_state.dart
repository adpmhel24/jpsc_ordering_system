part of 'inv_adj_out_bloc.dart';

class InvAdjustmentOutBlocStates extends Equatable {
  final FetchingStatus status;
  final List<InventoryAdjustmentOutModel> datas;
  final bool isCanceled;
  final String docstatus;
  final String fromDate;
  final String toDate;
  final String message;

  const InvAdjustmentOutBlocStates({
    this.status = FetchingStatus.init,
    this.docstatus = DocStatus.closed,
    this.isCanceled = false,
    this.fromDate = "",
    this.toDate = "",
    this.datas = const [],
    this.message = "",
  });

  InvAdjustmentOutBlocStates copyWith({
    FetchingStatus? status,
    List<InventoryAdjustmentOutModel>? datas,
    bool? isCanceled,
    String? docstatus,
    String? fromDate,
    String? toDate,
    String? message,
  }) {
    return InvAdjustmentOutBlocStates(
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
