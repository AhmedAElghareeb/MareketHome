import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_home/core/end_points.dart';
import 'package:market_home/services/dio.dart';
import 'package:market_home/views/auth/login/model.dart';
import 'package:market_home/views/auth/login/states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginStates());

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(
      LoadingLoginState(),
    );
    DioHelper.i.postData(
      path: login,
      data: {
        "email": email,
        "password": password,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(
        SuccessLoginState(loginModel!),
      );
    }).catchError((error) {
      emit(
        FailedLoginState(
          error.toString(),
        ),
      );
    });
  }

  IconData suffix = Icons.visibility_outlined;

  bool isPasswordShow = true;

  void changePassVisibility() {
    isPasswordShow = !isPasswordShow;

    suffix = isPasswordShow
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ChangePassState());
  }
}
