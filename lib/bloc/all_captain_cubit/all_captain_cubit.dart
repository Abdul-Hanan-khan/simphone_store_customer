import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/api_response/all_captain_api_response.dart';
import '../../resources/repository.dart';

part 'all_captain_state.dart';

class AllCaptainCubit extends Cubit<AllCaptainState> {
  AllCaptainCubit() : super(AllInitial());

  final repository = Repository();

  Future<void> allCaptain() async {
    emit(LoadingState());
    final AllCaptainApiResponse apiResponse = await repository.allCaptain();
    if (apiResponse.result == true) {
      emit(SuccessfullyGetFetchedAllCaptain(apiResponse.captains!));
    } else {
      emit(FailedToFetchedCaptain(apiResponse.message ?? "Failed To Fetched Captain!"));
    }
  }


}
