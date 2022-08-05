import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/api_response/all_devices_api_response.dart';
import '../../models/api_response/order_product_api_response.dart';
import '../../resources/repository.dart';

part 'all_devices_state.dart';

class AllDevicesCubit extends Cubit<AllDevicesState> {
  AllDevicesCubit() : super(AllDevicesInitial());

  final repository = Repository();

  Future<void> allDevices() async {
    emit(LoadingState());
    final AllDevicesApiResponse apiResponse = await repository.allDevices();
    if (apiResponse.result == true) {
      emit(AllDevicesFetchedSuccessfully(apiResponse.devices!));
    } else {
      emit(FailedToFetchedDevices(apiResponse.message ?? "Failed To Fetched Devices!"));
    }
  }

  Future<void> orderDevice(
      {required String productId,
      required String name,
      required String phone,
      required String address,
      required String email,
      required String lat,
      required String long}) async {
    emit(LoadingState());

    var _formData = {
      'productId': productId,
      "productType": "wifiDevice",
      "lat": lat,
      "long": long,
      "name": name,
      "phone": phone,
      "address": address,
      "email": email
    };

    final OrderProductApiResponse apiResponse = await repository.simOrderRequest(_formData);
    if (apiResponse.result == true) {
      emit(OrderDeviceSuccessfully(apiResponse.message ?? "Device Order Successfully",apiResponse));
    } else {
      emit(FailedToOrderDevice(apiResponse.message ?? "Failed To Order Device!"));
    }
  }
}
