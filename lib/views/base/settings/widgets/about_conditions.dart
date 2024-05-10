import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_home/core/shimmer_loading.dart';
import 'package:market_home/views/base/settings/settings_cubit/cubit.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit()..getData(),
      child: BlocConsumer<SettingsCubit, SettingsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = SettingsCubit.get(context);
          return ConditionalBuilder(
            condition: state is! LoadingSettingsState,
            builder: (context) => Scaffold(
              appBar: AppBar(
                title: Text(
                  type,
                ),
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsetsDirectional.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/images/1.png",
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "$type : \n ${type == cubit.model!.data.about ? cubit.model!.data.about : cubit.model!.data.terms}",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            fallback: (context) => ShimmerLoading(
              child: buildShimmer(),
            ),
          );
        },
      ),
    );
  }

  Widget buildShimmer() => Container(
        color: Colors.grey,
      );
}
