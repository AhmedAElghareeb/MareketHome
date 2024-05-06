import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_home/core/themes.dart';
import 'package:market_home/core/widgets.dart';
import 'package:market_home/views/base/home/cubit.dart';
import 'package:market_home/views/base/home/model.dart';
import 'package:market_home/views/base/home/states.dart';

//Products View
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getHomeData(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = HomeCubit.get(context);
          return SafeArea(
            child: ConditionalBuilder(
              condition: cubit.homeModel != null,
              builder: (context) => buildProductsBuilder(
                context,
                model: cubit.homeModel!,
              ),
              fallback: (context) => const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildProductsBuilder(BuildContext context,
          {required HomeModel model}) =>
      SingleChildScrollView(
        child: Column(
          children: [
            buildBanners(model),
            const SizedBox(
              height: 12,
            ),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1 / 1.59,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                model.data.products.length,
                (index) => buildItemOfGrid(
                  model.data.products[index],
                  index,
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildItemOfGrid(ProductsModel model, int index) => Container(
        color: Colors.white,
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
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          // print("Added");
                        },
                        icon: const Icon(
                          Icons.favorite_border,
                          size: 16,
                        ),
                        padding: EdgeInsets.zero,
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
      );

  Widget buildBanners(HomeModel model) => CarouselSlider(
        items: [
          ...List.generate(
            model.data.banners.length,
            (index) => cachedImage(
              imageUrl: model.data.banners[index].image,
              width: double.infinity,
              fit: BoxFit.cover,
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
