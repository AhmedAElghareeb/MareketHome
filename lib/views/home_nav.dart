import 'package:flutter/material.dart';
import 'package:market_home/core/custom_image.dart';
import 'package:market_home/core/themes.dart';
import 'package:market_home/views/base/categories/view.dart';
import 'package:market_home/views/base/favourite/view.dart';
import 'package:market_home/views/base/home/view.dart';
import 'package:market_home/views/base/notification/view.dart';
import 'package:market_home/views/base/settings/view.dart';

class HomeNav extends StatefulWidget {
  const HomeNav({super.key});

  @override
  State<HomeNav> createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {
  int current = 0;

  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    initPages();
  }

  void initPages() {
    pages = const [
      HomeView(),
      CategoriesView(),
      FavouriteView(),
      NotificationView(),
      SettingsView(),
    ];
  }

  List<Map<String, dynamic>> icons = [
    {
      "name": "Home",
      "icon": "assets/icons/home.svg",
    },
    {
      "name": "Categories",
      "icon": "assets/icons/category.svg",
    },
    {
      "name": "Favourites",
      "icon": "assets/icons/favourite.svg",
    },
    {
      "name": "Notification",
      "icon": "assets/icons/notification.svg",
    },
    {
      "name": "Settings",
      "icon": "assets/icons/settings.svg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[current],
      bottomSheet: Padding(
        padding: const EdgeInsets.only(
          right: 20,
          left: 20,
          bottom: 30,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              12,
            ),
            color: Colors.white,
          ),
          child: Row(
            children: List.generate(
              icons.length,
              (index) => Expanded(
                child: GestureDetector(
                  onTap: () {
                    current = index;
                    setState(() {});
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(
                          10,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index == current
                              ? AppColors.primary.withOpacity(0.10)
                              : null,
                        ),
                        child: CustomImage(
                          icons[index]["icon"],
                          color: index == current
                              ? AppColors.primary
                              : AppColors.secondary,
                          height: 20,
                          width: 20,
                          fit: BoxFit.fill,
                        ),
                      ),
                      if (index == current)
                        Text(
                          icons[index]["name"],
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
