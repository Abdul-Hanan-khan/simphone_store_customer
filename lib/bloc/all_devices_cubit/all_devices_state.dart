part of 'all_devices_cubit.dart';

abstract class AllDevicesState extends Equatable {
  const AllDevicesState();

  @override
  List<Object> get props => [];
}

class AllDevicesInitial extends AllDevicesState {}

class LoadingState extends AllDevicesState {}

class AllDevicesFetchedSuccessfully extends AllDevicesState {
  final List<Devices> devices;

  const AllDevicesFetchedSuccessfully(this.devices);
}

class FailedToFetchedDevices extends AllDevicesState {
  final String message;

  const FailedToFetchedDevices(this.message);
}
class OrderDeviceSuccessfully extends AllDevicesState {
  final String message;
  final OrderProductApiResponse orderProductApiResponse;

  const OrderDeviceSuccessfully(this.message,this.orderProductApiResponse);
}
class FailedToOrderDevice extends AllDevicesState {
  final String message;

  const FailedToOrderDevice(this.message);
}