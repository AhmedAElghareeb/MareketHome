import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_home/core/cache.dart';
import 'package:market_home/core/helper.dart';
import 'package:market_home/core/widgets.dart';
import 'package:market_home/views/home/view.dart';
import 'package:market_home/views/login/cubit.dart';
import 'package:market_home/views/login/states.dart';
import 'package:market_home/views/register/view.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is SuccessLoginState) {
            if (state.loginModel.status) {
              FlashHelper.showToast(state.loginModel.message,
                  type: MessageType.success);
              CachedData.saveUserData(
                key: "token",
                value: state.loginModel.data.token,
              );
              pushAndRemoveUntil(const HomeView());
            } else {
              FlashHelper.showToast(state.loginModel.message);
            }
          }
        },
        builder: (context, state) {
          final cubit = LoginCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 16,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        buildAuthHeader(
                          context,
                          path: "login",
                          text: "Please, Enter Your mail and password!!",
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        appInput(
                          context,
                          controller: emailCtrl,
                          textInputType: TextInputType.emailAddress,
                          label: "Email",
                          prefixIcon: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        appInput(
                          context,
                          controller: passwordCtrl,
                          isPassword: cubit.isPasswordShow,
                          textInputType: TextInputType.visiblePassword,
                          label: "Password",
                          prefixIcon: Icons.lock_outline,
                          suffixIcon: cubit.suffix,
                          onSuffixPressed: () {
                            cubit.changePassVisibility();
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoadingLoginState,
                          builder: (context) => appButton(
                            context,
                            onPress: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userLogin(
                                  email: emailCtrl.text,
                                  password: passwordCtrl.text,
                                );
                              }
                            },
                            text: "Login",
                          ),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        buildAuthFooter(
                          context,
                          text: "Don't Have an Account? ",
                          subText: "Register",
                          onTap: () {
                            push(
                              RegisterView(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
