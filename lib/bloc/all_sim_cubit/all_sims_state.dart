part of 'all_sims_cubit.dart';

abstract class AllSimsState extends Equatable {
  const AllSimsState();

  @override
  List<Object> get props => [];
}

class AllSimsInitial extends AllSimsState {}

class LoadingState extends AllSimsState {}

class AllSimsFetchedSuccessfully extends AllSimsState {
  final List<CaptainSims> allSims;

  const AllSimsFetchedSuccessfully(this.allSims);
}

class FailedToFetchedSims extends AllSimsState {
  final String message;

  const FailedToFetchedSims(this.message);
}

class SimOrderSuccessfully extends AllSimsState {
  final String message;
  final OrderProductApiResponse orderProductApiResponse;

  const SimOrderSuccessfully(this.message,this.orderProductApiResponse);
}

class FailedToOrderSim extends AllSimsState {
  final String message;

  const FailedToOrderSim(this.message);
}

