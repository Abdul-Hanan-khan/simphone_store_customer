import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/api_response/sign_in_api_response.dart';
import '../../../resources/repository.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  final repository = Repository();

  Future<void> signInWithEmail({required String email, required String password}) async {
    emit(LoadingState());
    var _formData = {'email': email, 'password': password};
    print(_formData);
    final SignInApiResponse signInModel = await repository.signIn(_formData);
    if (signInModel.result == true) {
      // storeToken(signInModel.data!.token!);
      emit(SignInSuccessful(signInModel));

    } else {
      emit(const SignInFailed("Sign In Failed"));
    }
  }


}
