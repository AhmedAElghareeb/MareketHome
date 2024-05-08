import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_home/core/helper.dart';
import 'package:market_home/core/shimmer_loading.dart';
import 'package:market_home/core/themes.dart';
import 'package:market_home/core/widgets.dart';
import 'package:market_home/views/base/categories/cubit.dart';
import 'package:market_home/views/base/categories/model.dart';
import 'package:market_home/views/base/categories/view.dart';
import 'package:market_home/views/base/home/cubit.dart';
import 'package:market_home/views/base/home/model.dart';
import 'package:market_home/views/base/home/states.dart';

//Products View
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // bool isFavorites = false;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit()..getHomeData(),
        ),
        BlocProvider(
          create: (context) => CategoriesCubit()..getCategories(),
        ),
        // BlocProvider(
        //   create: (context) => FavoritesCubit(),
        // ),
      ],
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final homeCubit = HomeCubit.get(context);
          final categoriesCubit = CategoriesCubit.get(context);
          return SafeArea(
            child: ConditionalBuilder(
              condition: homeCubit.homeModel != null &&
                  categoriesCubit.categoriesModel != null,
              builder: (context) => buildProductsBuilder(
                context,
                // isFavorites,
                model: homeCubit.homeModel!,
                categoriesModel: categoriesCubit.categoriesModel!,
              ),
              fallback: (context) => const ShimmerLoading(),
            ),
          );
        },
      ),
    );
  }

  Widget buildProductsBuilder(BuildContext context,
          // bool isFav,
          {required HomeModel model,
          required CategoriesModel categoriesModel}) =>
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildBanners(model),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Categories",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      push(const CategoriesView());
                    },
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: const Text(
                      "See All",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 150,
              child: ListView.builder(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 12),
                itemBuilder: (context, index) => buildCategoryItem(
                  categoriesModel.data.list[index],
                ),
                itemCount: categoriesModel.data.list.length,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 12),
              child: Text(
                "All Products",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 12),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 1 / 1.57,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                  model.data.products.length,
                  (index) => buildItemOfGrid(
                    context,
                    model.data.products[index],
                    index,
                    // isFav,
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildCategoryItem(CategoriesDataModel model) => Padding(
        padding: const EdgeInsetsDirectional.only(
          end: 12,
        ),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              cachedImage(
                imageUrl: model.image,
                fit: BoxFit.cover,
                width: 150,
                height: 150,
              ),
              Container(
                color: Colors.black.withOpacity(0.8),
                width: 150,
                child: Text(
                  model.name.toUpperCase(),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildItemOfGrid(
    BuildContext context,
    ProductsModel model,
    int index,
    // bool isFav,
  ) =>
      Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                cachedImage(
                  imageUrl: model.image,
                  width: double.infinity,
                  height: 200,
                ),
                if (model.discount != 0)
                  Container(
                    color: Colors.lightBlue,
                    padding:
                        const EdgeInsetsDirectional.symmetric(horizontal: 5),
                    child: Text(
                      "${model.discount} %",
                      style: const TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsetsDirectional.all(3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.3,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "${model.price} EGP",
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      if (model.discount != 0)
                        Text(
                          "${model.oldPrice} EGP",
                          style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      // const Spacer(),
                      // IconButton(
                      //   onPressed: () {
                      //     // if(isFav)
                      //     // {
                      //     //   FavoritesCubit.get(context).changeFavorites(
                      //     //     id: model.id,
                      //     //   );
                      //     // } else
                      //     // {
                      //     //
                      //     // }
                      //   },
                      //   icon: CircleAvatar(
                      //     radius: 15,
                      //     // backgroundColor: HomeCubit.get(context).homeModel!.data.products[index].inFavourite ? AppColors.primary : Colors.grey,
                      //     child: const Icon(
                      //       Icons.favorite_border,
                      //       size: 14,
                      //       color: Colors.white,
                      //     ),
                      //   ),
                      //   highlightColor: Colors.transparent,
                      //   splashColor: Colors.transparent,
                      //   hoverColor: Colors.transparent,
                      //   focusColor: Colors.transparent,
                      //   disabledColor: Colors.transparent,
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget buildBanners(HomeModel model) => CarouselSlider(
        items: [
          ...List.generate(
            model.data.banners.length,
            (index) => Container(
              margin: const EdgeInsetsDirectional.symmetric(
                horizontal: 12,
              ),
              clipBehavior: Clip.antiAlias,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: cachedImage(
                imageUrl: model.data.banners[index].image,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
        options: CarouselOptions(
          height: 200,
          autoPlay: true,
          viewportFraction: 1,
          enableInfiniteScroll: true,
          autoPlayInterval: const Duration(
            seconds: 2,
          ),
          autoPlayAnimationDuration: const Duration(
            seconds: 3,
          ),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
        ),
      );
}
