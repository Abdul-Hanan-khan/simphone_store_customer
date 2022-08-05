part of 'all_phones_cubit.dart';

abstract class AllPhonesState extends Equatable {
  const AllPhonesState();

  @override
  List<Object> get props => [];
}

class AllPhonesInitial extends AllPhonesState {

}
class LoadingState extends AllPhonesState {}

class AllPhonesFetchedSuccessfully extends AllPhonesState {
  final List<Mobiles> phones;

  const AllPhonesFetchedSuccessfully(this.phones);
}

class FailedToFetchedPhone extends AllPhonesState {
  final String message;

  const FailedToFetchedPhone(this.message);
}

class AddDeviceSuccessfully extends AllPhonesState {
  final String message;

  const AddDeviceSuccessfully(this.message);
}
class OrderPhoneSuccessfully extends AllPhonesState {
  final String message;
  final OrderProductApiResponse orderProductApiResponse;

  const OrderPhoneSuccessfully(this.message,this.orderProductApiResponse);
}

class FailedToAddDevice extends AllPhonesState {
  final String message;

  const FailedToAddDevice(this.message);
}
class FailedToOrderPhone extends AllPhonesState {
  final String message;

  const FailedToOrderPhone(this.message);
}