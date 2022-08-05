part of 'drawer_cubit.dart';

abstract class DrawerState extends Equatable {
  const DrawerState();

  @override
  List<Object> get props => [];
}

class DrawerInitial extends DrawerState {}
class LoadingState extends DrawerState{}

class GetUserSuccessfully extends DrawerState{
  final GetUserApiResponse userApiResponse;

  const GetUserSuccessfully(this.userApiResponse);
}
class FailedToGetUser extends DrawerState{
  final String message;

  const FailedToGetUser(this.message);
}