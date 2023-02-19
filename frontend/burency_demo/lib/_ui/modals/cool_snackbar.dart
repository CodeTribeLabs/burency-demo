import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:burency_demo/global_assets.dart';
import 'package:burency_demo/global_styles.dart';
import 'package:burency_demo/theme.dart';

class SnackBarType {
  static const String help = 'help';
  static const String failure = 'failure';
  static const String success = 'success';
  static const String information = 'information';
}

class CoolSnackbar extends StatelessWidget {
  static const String moduleName = 'CoolSnackbar';

  /// `IMPORTANT NOTE` for SnackBar properties before putting this in `content`
  /// set backgroundColor: Colors.transparent
  /// set behavior: SnackBarBehavior.floating
  /// set elevation: 0.0

  /// title is the header String that will show on top
  final String title;

  /// message String is the body message which shows only 2 lines at max
  final String message;

  /// `optional` color of the SnackBar body
  final Color? color;

  /// contentType will reflect the overall theme of SnackBar: failure, success, help, warning
  final String contentType;

  final bool dismissible;

  const CoolSnackbar({
    Key? key,
    this.color,
    required this.title,
    required this.message,
    required this.contentType,
    this.dismissible = true,
  }) : super(key: key);

  /// Reflecting proper icon based on the contentType
  String _getAssetSVG(String snackBarType) {
    if (snackBarType == SnackBarType.success) {
      /// success will show `CHECK`
      return GlobalAssets.snackbarSuccess;
    } else if (snackBarType == SnackBarType.information) {
      /// warning will show `EXCLAMATION`
      return GlobalAssets.snackbarInformation;
    } else if (snackBarType == SnackBarType.help) {
      /// help will show `QUESTION MARK`
      return GlobalAssets.snackbarHelp;
    } else {
      /// failure will show `CROSS`
      //return GlobalAssets.snackbarFailure;
      return GlobalAssets.snackbarInformation;
    }
  }

  Color _getSnackBarColor(String snackBarType) {
    final themeManager = ThemeManager.getInstance();

    switch (snackBarType) {
      case SnackBarType.help:
        return themeManager.helpColor;
      case SnackBarType.failure:
        return themeManager.failureColor;
      case SnackBarType.success:
        return themeManager.successColor;
      default:
        return themeManager.informationColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    const double containerWidth = 300;
    const double containerHeight = 80;
    const double iconSize = kXLargeIconSize;

    /// For reflecting different color shades in the SnackBar
    final hsl = HSLColor.fromColor(color ?? _getSnackBarColor(contentType));
    final hslDark = hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 1.0));

    final theme = Theme.of(context);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: kBasePadding,
              vertical: kBasePadding,
            ),
            height: containerHeight, //screenHeight * 0.125,
            width: containerWidth,
            decoration: BoxDecoration(
              color: color ?? _getSnackBarColor(contentType),
              borderRadius: BorderRadius.circular(kBaseBorderRadius),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: iconSize + kBasePadding2,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// `title` parameter
                      if (title.isNotEmpty)
                        Text(
                          title,
                          style: theme.textTheme.titleMedium!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      /// `message` body text parameter
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            message,
                            maxLines: 2,
                            style: theme.textTheme.bodyLarge!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (dismissible)
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () =>
                          ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                      child: SvgPicture.asset(
                        GlobalAssets.snackbarFailure,
                        height: 24,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(kBaseBorderRadius),
              ),
              child: SvgPicture.asset(
                GlobalAssets.snackbarBubbles,
                height: iconSize,
                width: iconSize,
                color: hslDark.toColor(),
              ),
            ),
          ),
          Positioned(
            top: -kBasePadding2,
            left: kBasePadding,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  GlobalAssets.snackbarBack,
                  height: iconSize,
                  color: hslDark.toColor(),
                ),
                Positioned(
                  top: kBasePadding * 0.5,
                  child: SvgPicture.asset(
                    _getAssetSVG(contentType),
                    height: kBigIconSize,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
