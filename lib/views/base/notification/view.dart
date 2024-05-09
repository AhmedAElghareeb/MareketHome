import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_home/core/shimmer_loading.dart';
import 'package:market_home/core/themes.dart';
import 'package:market_home/core/widgets.dart';
import 'package:market_home/views/base/notification/cubit.dart';
import 'package:market_home/views/base/notification/model.dart';
import 'package:market_home/views/base/notification/states.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationsCubit()..getData(),
      child: BlocConsumer<NotificationsCubit, NotificationsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = NotificationsCubit.get(context);
            return SafeArea(
              child: ConditionalBuilder(
                condition: cubit.model != null,
                builder: (context) => ListView.separated(
                  itemBuilder: (context, index) => buildListItem(
                    model: cubit.model!.data.list[index],
                  ),
                  separatorBuilder: (context, index) => buildDivider(),
                  itemCount: cubit.model!.data.list.length,
                ),
                fallback: (context) => ShimmerLoading(
                  child: buildShimmerItem(),
                ),
              ),
            );
          }),
    );
  }

  Widget buildListItem({required DataModel model}) => Padding(
        padding: const EdgeInsetsDirectional.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              model.message,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );

  Widget buildShimmerItem() => Padding(
        padding: const EdgeInsetsDirectional.all(20),
        child: ListView.separated(
          itemBuilder: (context, index) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 80,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 200,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
          separatorBuilder: (context, index) => Divider(
            endIndent: 20,
            indent: 20,
            thickness: 4,
            color: AppColors.primary.withOpacity(0.2),
          ),
          itemCount: 10,
        ),
      );
}
