import 'package:flutter/material.dart';
import 'package:market_home/core/helper.dart';
import 'package:market_home/views/login/view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image, title, subTitle;

  BoardingModel({
    required this.image,
    required this.title,
    required this.subTitle,
  });
}

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  List<BoardingModel> onBoarding = [
    BoardingModel(
      image: "assets/images/1.png",
      title: "Title 1",
      subTitle: "Sub Title 1",
    ),
    BoardingModel(
      image: "assets/images/2.png",
      title: "Title 2",
      subTitle: "Sub Title 2",
    ),
    BoardingModel(
      image: "assets/images/3.png",
      title: "Title 3",
      subTitle: "Sub Title 3",
    ),
  ];

  final pageCtrl = PageController();

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      actions: [
        TextButton(
          onPressed: () {
            pushAndRemoveUntil(const LoginView());
          },
          child: Text(
            "SKIP",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.all(30),
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemBuilder: (context, index) =>
                  buildOnBoardingItem(onBoarding[index]),
              itemCount: onBoarding.length,
              controller: pageCtrl,
              onPageChanged: (idx) {
                if (idx == onBoarding.length - 1) {
                  isLast = true;
                  setState(() {});
                } else {
                  isLast = false;
                  setState(() {});
                }
              },
            ),
          ),
          Row(
            children: [
              SmoothPageIndicator(
                controller: pageCtrl,
                count: onBoarding.length,
                effect: ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  activeDotColor: Theme.of(context).primaryColor,
                  dotHeight: 10,
                  dotWidth: 13,
                  spacing: 6,
                  expansionFactor: 5,
                ),
              ),
              const Spacer(),
              FloatingActionButton(
                onPressed: () {
                  if (isLast) {
                    pushAndRemoveUntil(const LoginView());
                  } else {
                    pageCtrl.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInToLinear,
                    );
                  }
                },
                child: const Icon(Icons.arrow_forward_ios),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildOnBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.asset(
              model.image,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            model.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            model.subTitle,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      );
}