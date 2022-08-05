import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/api_response/all_sim_api_response.dart';
import '../../models/api_response/order_product_api_response.dart';
import '../../resources/repository.dart';

part 'all_sims_state.dart';

class AllSimsCubit extends Cubit<AllSimsState> {
  AllSimsCubit() : super(AllSimsInitial());

  final repository = Repository();

  Future<void> allSims() async {
    emit(LoadingState());
    final AllSimApiResponse apiResponse = await repository.allSim();
    if (apiResponse.result == true) {
      emit(AllSimsFetchedSuccessfully(apiResponse.data!));
    } else {
      emit(FailedToFetchedSims(apiResponse.message ?? "Failed To Fetched Sims!"));
    }
  }

  Future<void> searchSims({String? series, String? no}) async {
    emit(LoadingState());
    var data;
    if (series != null && no == null) {
      data = {"series": series};
    } else if (no != null && series == null) {
      data = {"no": no};
    } else if (no != null && series != null) {
      data = {"series": series, "no": no};
    }
    final AllSimApiResponse apiResponse = await repository.searchSim(data);
    if (apiResponse.result == true) {
      emit(AllSimsFetchedSuccessfully(apiResponse.data?? []));
    } else {
      emit(FailedToFetchedSims(apiResponse.message ?? "Failed To Fetched Sims!"));
    }
  }

  Future<void> simOrder(
      {required String simId,
      required String name,
      required String phone,
      required String address,
      required String email,
      required String lat,
      required String long}) async {
    emit(LoadingState());
    var _formData = {
      'productId': simId,
      "productType": "sim",
      "lat": lat,
      "long": long,
      "name": name,
      "phone": phone,
      "address": address,
      "email": email
    };

    final OrderProductApiResponse apiResponse = await repository.simOrderRequest(_formData);
    if (apiResponse.result == true) {
      emit(SimOrderSuccessfully(apiResponse.message ?? "Sim Order Successfully",apiResponse));
    } else {
      emit(FailedToOrderSim(apiResponse.message ?? "Failed To Order Sim!"));
    }
  }
}
