import 'package:flutter/material.dart';
import 'package:market_home/core/widgets.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 16,
            ),
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
                  textInputType: TextInputType.visiblePassword,
                  label: "Password",
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: Icons.visibility_outlined,
                ),
                const SizedBox(
                  height: 40,
                ),
                appButton(
                  context,
                  onPress: () {},
                  text: "Login",
                ),
                const SizedBox(
                  height: 30,
                ),
                buildAuthFooter(
                  context,
                  text: "Don't Have an Account? ",
                  subText: "Register",
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
