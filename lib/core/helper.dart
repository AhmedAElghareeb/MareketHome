import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future push(Widget child) {
  return Navigator.of(navigatorKey.currentContext!).push(
    MaterialPageRoute(
      builder: (context) => (child),
    ),
  );
}

pushBack([dynamic data]) {
  return Navigator.of(navigatorKey.currentContext!).pop(
    data,
  );
}

pushReplacement(Widget child) {
  return Navigator.of(navigatorKey.currentContext!).pushReplacement(
    MaterialPageRoute(
      builder: (context) => child,
    ),
  );
}

pushAndRemoveUntil(Widget child) {
  return Navigator.of(navigatorKey.currentContext!).pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (context) => child,
    ),
    (route) => false,
  );
}
