part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object> get props => [];
}

class LoginInitialState extends AuthState {}

class LoginLoadingState extends AuthState{}

class UserLoginSuccessState extends AuthState{
  final User user;
  const UserLoginSuccessState({required this.user});
}

class AdminLoginSuccessState extends AuthState{}

class UserIncompleteInformation extends AuthState{}

class LoginErrorState extends AuthState{
  final String message;
  const LoginErrorState({required this.message});
}

class RegisterLoadingState extends AuthState{}

class RegisterSuccessState extends AuthState{}

class RegisterErrorState extends AuthState{
  final String message;
  const RegisterErrorState(this.message);
}


class EditUserLoadingState extends AuthState{}
class EditUserSuccessState extends AuthState{
}
class EditUserErrorState extends AuthState{
  final String message;
  const EditUserErrorState({required this.message});
}

