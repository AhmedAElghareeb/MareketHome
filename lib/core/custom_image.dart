import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:market_home/core/themes.dart';

class CustomImage extends StatelessWidget {
  final double? height, width;
  final String? url;
  final bool isFile;
  final BoxFit? fit;
  final BoxBorder? border;
  final Widget? child;
  final Function? onFinishLottie;

  final Color? blurColor, color, backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  const CustomImage(this.url,
      {super.key,
        this.height,
        this.width,
        this.isFile = false,
        this.borderRadius,
        this.fit,
        this.color,
        this.backgroundColor,
        this.border,
        this.child,
        this.blurColor,
        this.onFinishLottie});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(borderRadius: borderRadius ?? BorderRadius.zero, color: backgroundColor, border: border),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: Stack(
          children: [
            (() {
              if (url?.isNotEmpty != true) {
                return _errorWidget(context);
              } else if (url?.startsWith("http") == true) {
                return Image.network(
                  url!,
                  height: height,
                  width: width,
                  fit: fit ?? BoxFit.contain,
                  color: color,
                  errorBuilder: (context, error, stackTrace) => _errorWidget(context),
                );
              } else if (url?.split(".").last.toLowerCase() == "svg") {
                return SvgPicture.asset(
                  url!,
                  height: height,
                  width: width,
                  fit: fit ?? BoxFit.contain,
                  colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
                );
              } else if (url?.split(".").last.toLowerCase() == "json") {
                return CustomLottie(
                  url!,
                  height: height,
                  width: width,
                  fit: fit ?? BoxFit.contain,
                  onFinish: onFinishLottie,
                );
              } else if (isFile) {
                return Image.file(File(url!), height: height, width: width, fit: fit ?? BoxFit.contain, color: color);
              } else {
                return Image.asset(url!, width: width, height: height, fit: fit ?? BoxFit.contain, color: color);
              }
            })(),
            Container(
              height: height,
              width: width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: borderRadius ?? BorderRadius.zero,
                color: blurColor,
              ),
            ),
            if (child != null) Center(child: child!,),
          ],
        ),
      ),
    );
  }

  Widget _errorWidget(BuildContext context) => Container(
    decoration: BoxDecoration(
      borderRadius: borderRadius,
      border: border ?? Border.all(color: AppColors.primary),
    ),
    height: height,
    width: width,
    child: Container(
      constraints: const BoxConstraints(
        maxWidth: 30,
        maxHeight: 30,
      ),
      alignment: Alignment.center,
      child: const FittedBox(
        fit: BoxFit.fill,
        child: Icon(Icons.broken_image, color: AppColors.primary),
      ),
    ),
  );
}

class CustomLottie extends StatefulWidget {
  final double? height, width;
  final String? url;
  final BoxFit? fit;
  final Function? onFinish;
  const CustomLottie(this.url, {super.key, this.height, this.width, this.fit, this.onFinish});

  @override
  State<CustomLottie> createState() => _CustomLottieState();
}

class _CustomLottieState extends State<CustomLottie> with TickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      widget.url!,
      height: widget.height,
      width: widget.width,
      fit: widget.fit ?? BoxFit.contain,
      repeat: false,
      onLoaded: (composition) {
        _controller
          ..duration = composition.duration
          ..forward().whenComplete(
                () => Timer(const Duration(seconds: 1), () {
              if (widget.onFinish != null) widget.onFinish!();
            }),
          );
      },
    );
  }
}