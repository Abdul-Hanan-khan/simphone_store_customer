part of 'captain_sims_cubit.dart';

abstract class CaptainSimsState extends Equatable {
  const CaptainSimsState();

  @override
  List<Object> get props => [];
}

class CaptainSimsInitial extends CaptainSimsState {}

class LoadingState extends CaptainSimsState {}

class SimsGetsSuccessfully extends CaptainSimsState{
  final List<Sims>? sims;

  const SimsGetsSuccessfully(this.sims);
}

class FailedToFetchedCaptainSims extends CaptainSimsState {

  final String message;

  const FailedToFetchedCaptainSims(this.message);
}
