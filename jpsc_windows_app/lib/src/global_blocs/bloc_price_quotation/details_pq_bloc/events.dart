part of 'bloc.dart';

abstract class FetchingPQDetailsEvent extends Equatable {
  const FetchingPQDetailsEvent();
  @override
  List<Object?> get props => [];
}

class FetchedPQDetails extends FetchingPQDetailsEvent {
  final int id;
  const FetchedPQDetails(this.id);

  @override
  List<Object?> get props => [id];
}
