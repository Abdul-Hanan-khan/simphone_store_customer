part of 'sign_in_cubit.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInState {}

class LoadingState extends SignInState {}

class SignInSuccessful extends SignInState {
  final SignInApiResponse? response;

  const SignInSuccessful(this.response);
}

class SignInFailed extends SignInState {
  final String message;

  const SignInFailed(this.message);
}
