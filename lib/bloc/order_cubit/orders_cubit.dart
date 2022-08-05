import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sim_phone/models/api_response/customer_orders_api_response.dart';

import '../../resources/repository.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());

  final repository = Repository();

  Future<void> allOrders() async {
    emit(LoadingState());
    final CustomerOrdersApiResponse apiResponse = await repository.customerRequest();
    if (apiResponse.result == true) {
      emit(AllOrderFetchedSuccessfully(apiResponse.orders!));
    } else {
      emit(FailedToFetchedOrders(apiResponse.message ?? "Failed To Fetched Orders!"));
    }
  }


}
