import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:market_home/core/themes.dart';

Widget appInput(
  BuildContext context, {
  required String label,
  required TextEditingController controller,
  required TextInputType textInputType,
  required IconData prefixIcon,
  VoidCallback? onSuffixPressed,
  Function(String)? onSubmit,
  IconData? suffixIcon,
  bool isPassword = false,
}) =>
    TextFormField(
      controller: controller,
      onTapOutside: (evt) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      validator: (val) {
        if (val!.isEmpty) {
          return "This Field is Required!!!";
        } else if (textInputType == TextInputType.phone && val.length < 11) {
          return "Phone Number Must be 11 Digits!!";
        }
        return null;
      },
      keyboardType: textInputType,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Theme.of(context).primaryColor,
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: Theme.of(context).primaryColor,
          size: 22,
        ),
        suffixIcon: IconButton(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          icon: Icon(
            suffixIcon,
            color: Theme.of(context).primaryColor,
            size: 22,
          ),
          onPressed: onSuffixPressed,
        ),
      ),
    );

Widget appButton(
  BuildContext context, {
  required String text,
  required VoidCallback onPress,
  double? width,
  double? height,
}) =>
    FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        minimumSize: Size(
          width ?? double.infinity,
          height ?? 60,
        ),
      ),
      onPressed: onPress,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
    );

Widget buildAuthHeader(
  BuildContext context, {
  required String path,
  required String text,
}) =>
    Column(
      children: [
        SvgPicture.asset(
          "assets/icons/$path.svg",
          colorFilter: ColorFilter.mode(
            Theme.of(context).primaryColor.withOpacity(0.7),
            BlendMode.modulate,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          text,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, color: Colors.grey),
        ),
      ],
    );

Widget buildAuthFooter(
  BuildContext context, {
  required String text,
  required String subText,
  VoidCallback? onTap,
}) =>
    Text.rich(
      TextSpan(
        text: text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: subText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Theme.of(context).primaryColor,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );

// void printFullText(String? text) {
//   final pattern = RegExp('.{1,800}');
//   pattern.allMatches(text!).forEach(
//         (match) => print(
//           match.group(
//             0,
//           ),
//         ),
//       );
// }

Widget cachedImage({
  BoxFit? fit,
  double? width,
  double? height,
  required String imageUrl,
}) =>
    CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      errorWidget: (context, url, error) => const Icon(
        Icons.error_outline,
      ),
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

Widget buildDivider() => Divider(
  endIndent: 20,
  indent: 20,
  thickness: 4,
  color: AppColors.primary.withOpacity(0.2),
);

String token = "";
