part of 'orders_cubit.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object> get props => [];
}

class OrdersInitial extends OrdersState {}

class LoadingState extends OrdersState {}

class AllOrderFetchedSuccessfully extends OrdersState {
  final List<Orders> orders;

  const AllOrderFetchedSuccessfully(this.orders);
}

class FailedToFetchedOrders extends OrdersState {
  final String message;

  const FailedToFetchedOrders(this.message);
}
