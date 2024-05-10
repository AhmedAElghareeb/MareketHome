import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_home/core/shimmer_loading.dart';
import 'package:market_home/core/widgets.dart';
import 'package:market_home/views/base/settings/settings_cubit/cubit.dart';

class FaqsView extends StatelessWidget {
  const FaqsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit()..getFaqsData(),
      child: BlocConsumer<SettingsCubit, SettingsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = SettingsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text("Common Faqs"),
            ),
            body: ConditionalBuilder(
              condition: state is! LoadingFaqsState,
              builder: (context) => ListView.separated(
                itemBuilder: (context, index) => Padding(
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        cubit.faqsModel!.data.list[index].question
                            .toUpperCase(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        cubit.faqsModel!.data.list[index].answer,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                separatorBuilder: (context, index) => buildDivider(),
                itemCount: cubit.faqsModel!.data.list.length,
              ),
              fallback: (context) => ShimmerLoading(
                child: buildShimmer(),
              ),
            ),
          );
        },
      ),
    );
  }
  Widget buildShimmer() => ListView.separated(
    itemBuilder: (context, index) => Padding(
      padding:
      const EdgeInsetsDirectional.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 100,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 300,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    ),
    separatorBuilder: (context, index) => buildDivider(),
    itemCount: 5,
  );
}
