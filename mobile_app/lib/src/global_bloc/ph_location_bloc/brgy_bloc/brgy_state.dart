import 'package:equatable/equatable.dart';

import '../../../data/models/models.dart';

class BrgyState extends Equatable {
  const BrgyState();
  @override
  List<Object?> get props => [];
}

class BrgyInitState extends BrgyState {}

class BrgyLoadingState extends BrgyState {}

class BrgyLoadedState extends BrgyState {
  final List<BrgyModel> brgys;
  const BrgyLoadedState(this.brgys);
  @override
  List<Object?> get props => [brgys];
}

class BrgyEmptyState extends BrgyState {}

class BrgyErrorState extends BrgyState {
  final String message;
  const BrgyErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
