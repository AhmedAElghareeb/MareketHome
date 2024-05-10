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
          return Scaffold(
            appBar: AppBar(
              title: Text(
                type,
              ),
            ),
            body: ConditionalBuilder(
              builder: (context) => SingleChildScrollView(
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
              condition: state is! LoadingSettingsState,
              fallback: (context) => ShimmerLoading(
                child: buildShimmer(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildShimmer() => SingleChildScrollView(
    padding: const EdgeInsetsDirectional.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Container(
          width: 100,
          height: 20,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: 300,
          height: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey
          ),
        ),
      ],
    ),
  );
}
