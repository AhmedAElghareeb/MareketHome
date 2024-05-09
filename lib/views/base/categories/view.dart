import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_home/core/shimmer_loading.dart';
import 'package:market_home/core/themes.dart';
import 'package:market_home/core/widgets.dart';
import 'package:market_home/views/base/categories/cubit.dart';
import 'package:market_home/views/base/categories/model.dart';
import 'package:market_home/views/base/categories/states.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "All Categories",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => CategoriesCubit()..getCategories(),
        child: BlocConsumer<CategoriesCubit, CategoriesStates>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = CategoriesCubit.get(context);
            return ConditionalBuilder(
              condition: cubit.categoriesModel != null,
              builder: (context) => ListView.separated(
                itemBuilder: (context, index) => buildCategoryItem(
                  model: cubit.categoriesModel!.data.list[index],
                ),
                separatorBuilder: (context, index) => buildDivider(),
                itemCount: cubit.categoriesModel!.data.list.length,
              ),
              fallback: (context) => ShimmerLoading(
                child: buildShimmer(),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildCategoryItem({required CategoriesDataModel model}) => Padding(
        padding: const EdgeInsetsDirectional.all(20),
        child: Row(
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12)),
              child: cachedImage(
                imageUrl: model.image,
                width: 130,
                height: 130,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              model.name,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
            ),
          ],
        ),
      );

  Widget buildShimmer() => Padding(
        padding: const EdgeInsetsDirectional.all(20),
        child: ListView.separated(
          itemBuilder: (context, index) => Row(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey),
              ),
              const SizedBox(
                width: 20,
              ),
              Container(
                width: 120,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
              ),
              const Spacer(),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
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
