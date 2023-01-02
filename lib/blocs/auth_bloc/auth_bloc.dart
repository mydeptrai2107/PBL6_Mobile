// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pbl6/config/value.dart';
import 'package:pbl6/services/repository_account.dart';

import '../../models/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  RepositoryAccount repository;
  AuthBloc(this.repository) : super(LoginInitialState()) {
    on<LoginButtonPressEvent>(_onLoginButtonPress);
    on<RegisterButtonPressEvent>(_onRegisterButtonPress);
    on<EditUserButtonPressEvent>(_onEditUserButtonPress);
  }

  _onLoginButtonPress(
      LoginButtonPressEvent event, Emitter<AuthState> emit) async {
    emit(LoginLoadingState());
    var data = await repository.login(event.email, event.password);
    if (data == "sai") {
      emit(const LoginErrorState(message: "Tài Khoản Không Chính Xác"));
    } else {
      var user = await repository.getUser(event.email, event.password);
      accessToken = data;
      emit(UserLoginSuccessState(user: user));
    }
  }

  _onRegisterButtonPress(
      RegisterButtonPressEvent event, Emitter<AuthState> emit) async {
    emit(RegisterLoadingState());
    // ignore: unused_local_variable
    var data = await repository.register(event.email, event.password);
    if (data = true) {
      emit(RegisterSuccessState());
    } else {
      emit(const RegisterErrorState('Tài khoản đã tồn tại'));
    }
  }

  _onEditUserButtonPress(
      EditUserButtonPressEvent event, Emitter<AuthState> emit) async {
    emit(EditUserLoadingState());
    var data = await repository.editUser(event.user);
    if (data == 'đúng') {
      emit(EditUserSuccessState());
    } else {
      emit(const EditUserErrorState(message: 'Không thành công'));
    }
  }
}
