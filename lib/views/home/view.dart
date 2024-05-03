import 'package:flutter/material.dart';
import 'package:market_home/core/cache.dart';
import 'package:market_home/core/helper.dart';
import 'package:market_home/views/login/view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 200,
        actions: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: IconButton(
              onPressed: () {
                CachedData.clearUserData();
                pushAndRemoveUntil(LoginView());
              },
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.black,
                size: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
