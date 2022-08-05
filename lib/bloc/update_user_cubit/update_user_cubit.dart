import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sim_phone/models/api_response/update_user_api_response.dart';

import '../../resources/repository.dart';

part 'update_user_state.dart';

class UpdateUserCubit extends Cubit<UpdateUserState> {
  UpdateUserCubit() : super(UpdateUserInitial());

  final repository = Repository();

  Future<void> updateUser({
    String? name,
    String? address,
    String? phone,
    XFile? profileImage,
  }) async {
    emit(LoadingState());

    final _formData = FormData.fromMap({if (name != null) 'name': name, if (address != null) 'area': address, if (phone != null) 'phone': phone});
    if (profileImage != null) {
      _formData.files.add(MapEntry('avatar', await MultipartFile.fromFile(profileImage.path.toString(), filename: 'cover_image_${DateTime.now().millisecondsSinceEpoch}.png',
          contentType: MediaType("multipart", "form-data"))));
    }
    print(_formData);
    final UpdateUserApiResponse apiResponse = await repository.updateUser(name: name,address: address,phone: phone,imageFile: profileImage);
    if (apiResponse.result == true) {
      emit(SuccessfullyUpdateUser(apiResponse.message ?? "Successfully Update"));
    } else {
      emit(FailedToUpdateUser(apiResponse.message ?? "Failed To Update!"));
    }
  }
}
