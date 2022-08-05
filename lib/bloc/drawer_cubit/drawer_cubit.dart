import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/api_response/get_user_api_response.dart';
import '../../resources/repository.dart';

part 'drawer_state.dart';

class DrawerCubit extends Cubit<DrawerState> {
  DrawerCubit() : super(DrawerInitial());

  final repository = Repository();

  Future<void> getUser() async {
    emit(LoadingState());
    final GetUserApiResponse apiResponse = await repository.getUserRequest();
    if (apiResponse != null) {
      emit(GetUserSuccessfully(apiResponse));
    } else {
      emit(const FailedToGetUser("Failed To Fetched User!"));
    }
  }
}
