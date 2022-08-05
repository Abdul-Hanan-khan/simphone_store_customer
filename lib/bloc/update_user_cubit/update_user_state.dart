part of 'update_user_cubit.dart';

abstract class UpdateUserState extends Equatable {
  const UpdateUserState();

  @override
  List<Object> get props => [];
}

class UpdateUserInitial extends UpdateUserState {}

class LoadingState extends UpdateUserState {}

class SuccessfullyUpdateUser extends UpdateUserState {
  final String message;

  const SuccessfullyUpdateUser(this.message);
}

class FailedToUpdateUser extends UpdateUserState {
  final String message;

  const FailedToUpdateUser(this.message);
}
