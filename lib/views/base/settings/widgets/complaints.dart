import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_home/core/helper.dart';
import 'package:market_home/core/widgets.dart';
import 'package:market_home/views/base/settings/settings_cubit/cubit.dart';

class ComplaintsView extends StatelessWidget {
  ComplaintsView({super.key});

  final name = TextEditingController();
  final phone = TextEditingController();
  final mail = TextEditingController();
  final message = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(),
      child: BlocConsumer<SettingsCubit, SettingsStates>(
        listener: (context, state) {
          if (state is SuccessComplaintsState) {
            if (state.model.status) {
              FlashHelper.showToast(state.model.message,
                  type: MessageType.success);
            } else {
              FlashHelper.showToast(state.model.message);
            }
          }
        },
        builder: (context, state) {
          final cubit = SettingsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text("Complaints"),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsetsDirectional.all(15),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    appInput(
                      context,
                      label: "Name",
                      controller: name,
                      textInputType: TextInputType.name,
                      prefixIcon: Icons.person,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    appInput(
                      context,
                      label: "Phone",
                      controller: phone,
                      textInputType: TextInputType.phone,
                      prefixIcon: Icons.phone,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    appInput(
                      context,
                      label: "Email",
                      controller: mail,
                      textInputType: TextInputType.emailAddress,
                      prefixIcon: Icons.mail_lock_outlined,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    appInput(
                      context,
                      label: "Message",
                      controller: message,
                      textInputType: TextInputType.text,
                      prefixIcon: Icons.message_outlined,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: ConditionalBuilder(
                        condition: state is! LoadingComplaintsState,
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                        builder: (context) => appButton(
                          context,
                          text: "Send",
                          width: 200,
                          onPress: () {
                            if (formKey.currentState!.validate()) {
                              cubit.sendComplaints(
                                name: name.text,
                                phone: phone.text,
                                mail: mail.text,
                                msg: message.text,
                              );
                              name.clear();
                              phone.clear();
                              mail.clear();
                              message.clear();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
