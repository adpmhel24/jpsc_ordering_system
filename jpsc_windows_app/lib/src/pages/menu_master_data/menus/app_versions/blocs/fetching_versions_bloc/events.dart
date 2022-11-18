part of 'bloc.dart';

abstract class FetchingAppVersionsEvents extends Equatable {
  const FetchingAppVersionsEvents();
  @override
  List<Object?> get props => [];
}

class LoadAppVersions extends FetchingAppVersionsEvents {}
