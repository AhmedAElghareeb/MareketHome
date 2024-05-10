import 'package:flutter/material.dart';
import 'package:flash/flash.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

enum MessageType { success, fail, warning }

class FlashHelper {
  static Future<void> showToast(String msg,
      {int duration = 2, MessageType type = MessageType.fail}) async {
    if (msg.isEmpty) return;
    return showFlash(
      context: navigatorKey.currentContext!,
      builder: (context, controller) {
        return FlashBar(
          controller: controller,
          position: FlashPosition.bottom,
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Container(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: _getBgColor(
                type,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    msg,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                    softWrap: true,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 24,
                  width: 24,
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: SvgPicture.asset(
                    _getToastIcon(type),
                    height: 19,
                    width: 24,
                    color: _getBgColor(type),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      duration: const Duration(milliseconds: 3000),
    );
  }

static Color _getBgColor(MessageType msgType) {
  switch (msgType) {
    case MessageType.success:
      return Colors.green;
    case MessageType.warning:
      return Colors.yellow;
    default:
      return Colors.red;
  }
}

static String _getToastIcon(MessageType msgType) {
  switch (msgType) {
    case MessageType.success:
      return "assets/icons/success.svg";

    case MessageType.warning:
      return "assets/icons/warning.svg";

    default:
      return "assets/icons/failed.svg";
  }
}
}
