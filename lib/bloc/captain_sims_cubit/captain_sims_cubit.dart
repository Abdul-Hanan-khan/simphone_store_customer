import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/api_response/captain_sims_api_response.dart';
import '../../models/data_models/sim.dart';
import '../../resources/repository.dart';

part 'captain_sims_state.dart';

class CaptainSimsCubit extends Cubit<CaptainSimsState> {
  CaptainSimsCubit() : super(CaptainSimsInitial());


  final repository = Repository();

  Future<void> allCaptainSims({required String id}) async {
    emit(LoadingState());
    final CaptainSimsApiResponse apiResponse = await repository.allCaptainSims(id);
    if (apiResponse.result == true) {
      emit(SimsGetsSuccessfully(apiResponse.sims!));
    } else {
      emit(FailedToFetchedCaptainSims(apiResponse.message ?? "Failed To Fetched Captain Sims!"));
    }
  }


}
