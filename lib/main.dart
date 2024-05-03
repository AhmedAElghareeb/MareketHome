import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_home/core/cache.dart';
import 'package:market_home/core/helper.dart';
import 'package:market_home/observer.dart';
import 'package:market_home/views/home/view.dart';
import 'package:market_home/views/login/view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await CachedData.init();

  Widget? widget;

  bool onBoarding = CachedData.getData(key: "onBoarding") ?? false;
  String token = CachedData.getData(key: "token") ?? "";

  if (onBoarding) {
    if (token.isNotEmpty) {
      widget = const HomeView();
    } else {
      widget = LoginView();
    }
  }

  runApp(
    MyApp(
      start: widget!,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.start,
  });

  final Widget start;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: "BriemHand",
        platform: TargetPlatform.iOS,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark),
        ),
        useMaterial3: false,
      ),
      home: start,
    );
  }
}
