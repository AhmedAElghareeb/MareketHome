import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_home/core/shimmer_loading.dart';
import 'package:market_home/core/themes.dart';
import 'package:market_home/core/widgets.dart';
import 'package:market_home/views/base/favourite/model.dart';
import 'package:market_home/views/base/home/cubit.dart';
import 'package:market_home/views/base/home/states.dart';

class FavouriteView extends StatelessWidget {
  const FavouriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getFavData(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = HomeCubit.get(context);
          return cubit.model!.data.list.isEmpty
              ? const Center(
                  child: Text(
                    "No Data Founded...!!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                )
              : ConditionalBuilder(
                  condition: state is! LoadingFavoriteState,
                  builder: (context) => ListView.separated(
                    itemBuilder: (context, index) => buildFavoriteItem(
                      model: cubit.model!.data.list[index],
                      context,
                    ),
                    separatorBuilder: (context, index) => buildDivider(),
                    itemCount: cubit.model!.data.list.length,
                  ),
                  fallback: (context) => ShimmerLoading(
                    child: buildShimmer(),
                  ),
                );
        },
      ),
    );
  }

  Widget buildFavoriteItem(BuildContext context,
          {required FavDataModel model}) =>
      Padding(
        padding: const EdgeInsetsDirectional.all(20),
        child: Container(
          clipBehavior: Clip.antiAlias,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    cachedImage(
                      imageUrl: model.product.image,
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                    if (model.product.discount != 0)
                      Container(
                        color: Colors.lightBlue,
                        padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 5),
                        child: Text(
                          "${model.product.discount} %",
                          style: const TextStyle(
                              fontSize: 10, color: Colors.white),
                        ),
                      )
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.3,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          "${model.product.price} EGP",
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        if (model.product.discount != 0)
                          Text(
                            "${model.product.oldPrice} EGP",
                            style: const TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough),
                          ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            HomeCubit.get(context)
                                .addToFavorites(id: model.product.id);
                          },
                          padding: EdgeInsets.zero,
                          icon: Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.primary.withOpacity(0.5)),
                            child: Center(
                              child: Icon(
                                HomeCubit.get(context).fav[model.product.id]!
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 15,
                                color: HomeCubit.get(context)
                                        .fav[model.product.id]!
                                    ? Colors.red
                                    : Colors.white,
                              ),
                            ),
                          ),
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          disabledColor: Colors.transparent,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildShimmer() => ListView.separated(
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsetsDirectional.all(20),
          child: SizedBox(
            height: 150,
            child: Row(
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 200,
                        height: 20,
                        color: Colors.grey,
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Container(
                            width: 80,
                            height: 20,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Spacer(),
                          Container(
                            width: 30,
                            height: 20,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        separatorBuilder: (context, index) => buildDivider(),
        itemCount: 10,
      );
}
