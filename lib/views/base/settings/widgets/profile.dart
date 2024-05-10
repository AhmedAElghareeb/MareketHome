import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_home/core/widgets.dart';
import 'package:market_home/views/auth/login/cubit.dart';
import 'package:market_home/views/auth/login/states.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final nameCtrl = TextEditingController();
  final mailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = LoginCubit.get(context);
          var model = cubit.loginModel!.data;

          nameCtrl.text = model.name;
          mailCtrl.text = model.email;
          phoneCtrl.text = model.phone;

          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: const Text("Profile"),
              ),
              body: ConditionalBuilder(
                condition: LoginCubit.get(context).loginModel != null,
                builder: (context) =>  SingleChildScrollView(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 16,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if(state is UserUpdateDataLoadingState)
                          const LinearProgressIndicator(),
                        const SizedBox(
                          height: 20,
                        ),
                        appInput(
                          context,
                          label: "Name",
                          controller: nameCtrl,
                          textInputType: TextInputType.name,
                          prefixIcon: Icons.person,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        appInput(
                          context,
                          label: "Email",
                          controller: mailCtrl,
                          textInputType: TextInputType.emailAddress,
                          prefixIcon: Icons.mail,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        appInput(
                          context,
                          label: "Phone",
                          controller: phoneCtrl,
                          textInputType: TextInputType.phone,
                          prefixIcon: Icons.phone,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        appButton(
                          context,
                          width: 150,
                          text: "Update",
                          onPress: () {
                            if (formKey.currentState!.validate()) {
                              cubit.userUpdate(
                                name: nameCtrl.text,
                                email: mailCtrl.text,
                                phone: phoneCtrl.text,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
