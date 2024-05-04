import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_home/core/end_points.dart';
import 'package:market_home/services/dio.dart';
import 'package:market_home/views/login/model.dart';
import 'package:market_home/views/register/states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterStates());

  static RegisterCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(
      LoadingRegisterState(),
    );

    DioHelper.i.postData(
      path: register,
      data: {
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(
        SuccessRegisterState(
          loginModel!,
        ),
      );
    }).catchError((error) {
      emit(
        FailedRegisterState(
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
