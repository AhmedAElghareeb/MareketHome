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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = LoginCubit
              .get(context)
              .loginModel!.data;

          nameCtrl.text = model.name;
          mailCtrl.text = model.email;
          phoneCtrl.text = model.phone;

          return ConditionalBuilder(
            condition: LoginCubit
                .get(context)
                .loginModel != null,
            builder: (context) =>
                SafeArea(
                  child: Scaffold(
                    appBar: AppBar(
                      title: const Text("Profile"),
                    ),
                    body: SingleChildScrollView(
                      padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 16,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // const SizedBox(
                          //   height: 16,
                          // ),
                          // Center(
                          //   child: Container(
                          //     width: 100,
                          //     height: 100,
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(10),
                          //       color: Colors.white,
                          //     ),
                          //     child: cachedImage(
                          //       imageUrl: "",
                          //     ),
                          //   ),
                          // ),
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
                            onPress: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            fallback: (context) =>
            const Center(child: CircularProgressIndicator(),),
          );
        },
      ),
    );
  }
}
