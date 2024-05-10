import 'package:flutter/material.dart';
import 'package:market_home/core/cache.dart';
import 'package:market_home/core/helper.dart';
import 'package:market_home/core/themes.dart';
import 'package:market_home/core/widgets.dart';
import 'package:market_home/views/auth/login/view.dart';
import 'package:market_home/views/base/settings/widgets/about_conditions.dart';
import 'package:market_home/views/base/settings/widgets/profile.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              buildSettingItem(
                title: "Profile",
                onTap: () {
                  push(ProfileView());
                },
              ),
              buildSettingItem(
                title: "About",
                onTap: () {
                  push(
                    const AboutView(
                      type: "About",
                    ),
                  );
                },
              ),
              buildSettingItem(
                title: "Terms and Conditions",
                onTap: () {
                  push(
                    const AboutView(
                      type: "Terms and Conditions",
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 100,
              ),
              appButton(
                context,
                text: "Log Out",
                width: 200,
                height: 50,
                onPress: () {
                  signOut();
                },
              ),
              const SizedBox(
                height: 130,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSettingItem({
    required String title,
    VoidCallback? onTap,
  }) =>
      Padding(
        padding: const EdgeInsetsDirectional.only(
          start: 16,
          end: 16,
          top: 20,
        ),
        child: Container(
          height: 50,
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 16,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.primary.withOpacity(0.2)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.primary,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  void signOut() {
    CachedData.clearUserData().then((value) {
      if (value) {
        pushAndRemoveUntil(
          LoginView(),
        );
      }
    });
  }
}
