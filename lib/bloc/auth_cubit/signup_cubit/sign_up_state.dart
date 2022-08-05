part of 'sign_up_cubit.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class LoadingState extends SignUpState {}

class SignUpSuccessful extends SignUpState {
  final String message;

  const SignUpSuccessful(this.message);
}

class SignUpFailed extends SignUpState {
  final String message;

  const SignUpFailed(this.message);
}
