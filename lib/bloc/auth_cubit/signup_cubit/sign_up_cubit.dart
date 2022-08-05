import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sim_phone/common/common_variables.dart';

import '../../../models/api_response/sign_up_api_response.dart';
import '../../../resources/repository.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  final _repository = Repository();

  Future signUp(
      {required String userName,
      required String cnic,
      required String phoneNo,
      required String password,
      required String address,
      required String email,
      String? lat,
      String? long,
      XFile? imageFile}) async {
    emit(LoadingState());
    Map data = {
      "name": userName,
      "cnic": cnic,
      "email": email,
      "phone": phoneNo,
      "password": password.toString(),
      "role": "USER",
      "area": address
    };
    print(data);
    final SignUpApiResponse signUpModel = await _repository.signUp(
        name: userName,
        cnic: cnic,
        email: email,
        phone: phoneNo,
        password: password,
        address: address,
        lat: lat,
        long: long,
        imageFile: imageFile);
    if (signUpModel.result == true) {
      emit(const SignUpSuccessful("Sign Up Successfully"));
    } else {
      emit(const SignUpFailed("Sign Up Failed"));
    }
  }
}
