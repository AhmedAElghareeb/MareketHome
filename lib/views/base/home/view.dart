import 'package:flutter/material.dart';
import 'package:market_home/core/cache.dart';
import 'package:market_home/core/helper.dart';
import 'package:market_home/views/auth/login/view.dart';

//Products View
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Home"),
      ),
    );
  }
}
