import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_home/core/cache.dart';
import 'package:market_home/core/helper.dart';
import 'package:market_home/core/widgets.dart';
import 'package:market_home/views/auth/login/view.dart';
import 'package:market_home/views/auth/register/cubit.dart';
import 'package:market_home/views/auth/register/states.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is SuccessRegisterState) {
            if (state.loginModel.status) {
              FlashHelper.showToast(state.loginModel.message,
                  type: MessageType.success);
              CachedData.saveUserData(
                key: "token",
                value: state.loginModel.data.token,
              );
              pushAndRemoveUntil(LoginView());
            } else {
              FlashHelper.showToast(state.loginModel.message);
            }
          }
        },
        builder: (context, state) {
          final cubit = RegisterCubit.get(context);
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
                          text: "Please, Fill This Form to Register!!!",
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        appInput(
                          context,
                          controller: nameCtrl,
                          textInputType: TextInputType.name,
                          label: "Your Name",
                          prefixIcon: Icons.person,
                        ),
                        const SizedBox(
                          height: 15,
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
                          height: 15,
                        ),
                        appInput(
                          context,
                          controller: phoneCtrl,
                          textInputType: TextInputType.phone,
                          label: "Your Phone",
                          prefixIcon: Icons.phone,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoadingRegisterState,
                          builder: (context) => appButton(
                            context,
                            onPress: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userRegister(
                                    name: nameCtrl.text,
                                    email: emailCtrl.text,
                                    password: passwordCtrl.text,
                                    phone: phoneCtrl.text);
                              }
                            },
                            text: "Register",
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
                          text: "Have an Account? ",
                          subText: "Login",
                          onTap: () {
                            pushAndRemoveUntil(
                              LoginView(),
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
