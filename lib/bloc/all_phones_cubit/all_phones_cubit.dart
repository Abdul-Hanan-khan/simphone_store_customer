import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/api_response/all_phone_api_response.dart';
import '../../models/api_response/order_product_api_response.dart';
import '../../resources/repository.dart';

part 'all_phones_state.dart';

class AllPhonesCubit extends Cubit<AllPhonesState> {
  AllPhonesCubit() : super(AllPhonesInitial());

  final repository = Repository();

  Future<void> allPhones() async {
    emit(LoadingState());
    final AllPhoneApiResponse apiResponse = await repository.allPhone();
    if (apiResponse.result == true) {
      emit(AllPhonesFetchedSuccessfully(apiResponse.mobiles!));
    } else {
      emit(FailedToFetchedPhone(apiResponse.message ?? "Failed To Fetched Phones!"));
    }
  }

  Future<void> orderMobile(
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
      "productType": "mobile",
      "lat": lat,
      "long": long,
      "name": name,
      "phone": phone,
      "address": address,
      "email": email
    };

    final OrderProductApiResponse apiResponse = await repository.simOrderRequest(_formData);
    if (apiResponse.result == true) {
      emit(OrderPhoneSuccessfully(apiResponse.message ?? "Mobile Order Successfully",apiResponse));
    } else {
      emit(FailedToOrderPhone(apiResponse.message ?? "Failed To Order Mobile!"));
    }
  }
}
