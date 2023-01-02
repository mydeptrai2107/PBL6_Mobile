part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}


class StartEvent extends AuthEvent {}

class LoginButtonPressEvent extends AuthEvent{
  final String email;
  final String password;

  const LoginButtonPressEvent(this.email, this.password);
}

class RegisterButtonPressEvent extends AuthEvent {
  final String email;
  final String password;

  const RegisterButtonPressEvent(this.email, this.password);
}

class EditUserButtonPressEvent extends AuthEvent{
  final User user;

  const EditUserButtonPressEvent({required this.user});
}

