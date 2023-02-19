import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flash/flash.dart';
import 'package:shimmer/shimmer.dart';

import 'package:burency_demo/global_styles.dart';
import 'package:burency_demo/_ui/modals/cool_snackbar.dart';

class AppWidgetBuilder {
  AppWidgetBuilder();

  static bool isLandscape(double screenWidth) {
    return screenWidth >= 1024;
  }

  static double getLandscapeWidth(double screenWidth, {bool sidePanel = true}) {
    final landscapeWidth = sidePanel ? screenWidth * 0.3 : screenWidth * 0.7;
    return (landscapeWidth).round().toDouble();
  }

  static LinearGradient primaryGradient(
      {required Color primaryGradientDarkTone,
      required Color primaryGradientLightTone,
      bool vertical = true}) {
    return LinearGradient(
      begin: (vertical) ? Alignment.bottomCenter : Alignment.centerLeft,
      end: (vertical) ? Alignment.topCenter : Alignment.centerRight,
      colors: [primaryGradientLightTone, primaryGradientDarkTone],
    );
  }

  static LinearGradient secondaryGradient({bool vertical = true}) {
    return LinearGradient(
      begin: (vertical) ? Alignment.bottomCenter : Alignment.centerLeft,
      end: (vertical) ? Alignment.topCenter : Alignment.centerRight,
      colors: const [kSecondaryGradientLight, kSecondaryGradientDark],
    );
  }

  static LinearGradient linearGradient(
      {required Color startColor,
      required Color endColor,
      bool vertical = true}) {
    return LinearGradient(
      begin: (vertical) ? Alignment.topCenter : Alignment.centerLeft,
      end: (vertical) ? Alignment.bottomCenter : Alignment.centerRight,
      colors: [startColor, endColor],
    );
  }

  static Container headerBar({
    required Widget child,
    double horizontalPadding = 0,
    double verticalPadding = 0,
  }) {
    return Container(
      height: 32,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      width: double.infinity,
      color: kHeaderBackground,
      child: child,
    );
  }

  static Container panelHeaderBar({
    required Widget child,
    double horizontalPadding = 0,
    double verticalPadding = 0,
  }) {
    return Container(
      height: 32,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      width: double.infinity,
      color: kPanelHeaderBackground,
      child: child,
    );
  }

  static Container panelCell({
    required Widget child,
    bool bigCell = false,
    double cellHeight = 22,
  }) {
    return Container(
      width: double.infinity,
      height: bigCell ? cellHeight * 3 : cellHeight * 2,
      decoration: BoxDecoration(
        border: borderAll(bottom: 1, top: 0, left: 0, right: 0),
      ),
      child: child,
    );
  }

  static SizedBox horizontalSpacer({width = kBasePadding}) {
    return SizedBox(width: width);
  }

  static SizedBox verticalSpacer({height = kBasePadding}) {
    return SizedBox(height: height);
  }

  static Border outlineBorder(
      {Color color = Colors.black, double width = kBaseMargin}) {
    return borderAll(
      color: color,
      top: width,
      right: width,
      bottom: width,
      left: width,
    );
  }

  static Border borderAll({
    Color color = kBorderStroke,
    double top = 1,
    double right = 1,
    double bottom = 1,
    double left = 1,
  }) {
    return Border(
      top: BorderSide(color: color, width: top),
      right: BorderSide(color: color, width: right),
      bottom: BorderSide(color: color, width: bottom),
      left: BorderSide(color: color, width: left),
    );
  }

  static BoxDecoration primaryGradientBoxDecoration({
    required primaryGradientDarkTone,
    required primaryGradientLightTone,
    bool vertical = true,
    double borderRadius = kBaseBorderRadius,
  }) {
    return BoxDecoration(
      gradient: primaryGradient(
        vertical: vertical,
        primaryGradientDarkTone: primaryGradientDarkTone,
        primaryGradientLightTone: primaryGradientLightTone,
      ),
      borderRadius: BorderRadius.circular(borderRadius),
    );
  }

  static BoxDecoration secondaryGradientBoxDecoration({
    bool vertical = true,
    double borderRadius = kBaseBorderRadius,
  }) {
    return BoxDecoration(
      gradient: secondaryGradient(vertical: vertical),
      borderRadius: BorderRadius.circular(borderRadius),
    );
  }

  static BoxDecoration roundedBorderDecoration({
    Color color = kBorderStroke,
    Color fillColor = Colors.transparent,
    double width = 1,
    double radius = 1,
  }) {
    return BoxDecoration(
      border: Border.all(
        color: color,
        width: width,
      ),
      borderRadius: BorderRadius.circular(radius),
      color: fillColor,
    );
  }

  static BoxDecoration selectedBorderDecoration({
    Color color = kBorderStroke,
    Color fillColor = Colors.transparent,
    double topWidth = 1,
    double leftWidth = 1,
    double bottomWidth = 1,
    double rightWidth = 1,
    double topLeftRadius = 0,
    double bottomLeftRadius = 0,
    double bottomRightRadius = 0,
    double topRightRadius = 0,
  }) {
    return BoxDecoration(
      border: Border(
        top: (topWidth > 0)
            ? BorderSide(width: topWidth, color: color)
            : BorderSide.none,
        left: (leftWidth > 0)
            ? BorderSide(width: leftWidth, color: color)
            : BorderSide.none,
        bottom: (bottomWidth > 0)
            ? BorderSide(width: bottomWidth, color: color)
            : BorderSide.none,
        right: (rightWidth > 0)
            ? BorderSide(width: rightWidth, color: color)
            : BorderSide.none,
      ),
      borderRadius: BorderRadius.only(
        topLeft:
            (topLeftRadius > 0) ? Radius.circular(topLeftRadius) : Radius.zero,
        topRight: (topRightRadius > 0)
            ? Radius.circular(topRightRadius)
            : Radius.zero,
        bottomLeft: (bottomLeftRadius > 0)
            ? Radius.circular(bottomLeftRadius)
            : Radius.zero,
        bottomRight: (bottomRightRadius > 0)
            ? Radius.circular(bottomRightRadius)
            : Radius.zero,
      ),
      color: fillColor,
    );
  }

  static ButtonStyle outlineButtonStyle({
    double width = 50,
    double height = 36,
    double horizontalPadding = kBasePadding2,
    double verticalPadding = 0,
    double borderWidth = 1,
    double borderRadius = kBaseMargin,
    Color backgroundColor = Colors.transparent,
    Color borderColor = kGray500,
  }) {
    return OutlinedButton.styleFrom(
      elevation: 0,
      backgroundColor: backgroundColor,
      minimumSize: Size(width, height),
      fixedSize: Size(width, height),
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
    ).copyWith(
      side: MaterialStateProperty.resolveWith<BorderSide>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return BorderSide(
              color: borderColor,
              width: borderWidth,
            );
          }

          return BorderSide(
            color: borderColor,
            width: borderWidth,
          );
        },
      ),
    );
  }

  static InputDecoration textFieldOutlinedDecoration({
    required ThemeData theme,
    required Color warningColor,
    String hintText = '',
    IconData icon = Icons.person_outline,
    bool enabled = true,
    Color fillColor = Colors.white60,
    EdgeInsetsGeometry? padding,
    String? counterText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    var border = OutlineInputBorder(
      borderSide: BorderSide(color: theme.focusColor.withOpacity(0.3)),
      borderRadius: const BorderRadius.all(Radius.circular(kBaseBorderRadius)),
    );

    return InputDecoration(
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: padding,
      hintText: hintText,
      labelStyle: theme.textTheme.titleMedium!
          .copyWith(color: Colors.black87.withOpacity(0.5)),
      hintStyle: theme.textTheme.titleMedium!
          .copyWith(color: Colors.grey.withOpacity(1)),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      border: border,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: theme.primaryColor),
        borderRadius:
            const BorderRadius.all(Radius.circular(kBaseBorderRadius)),
      ),
      enabledBorder: border,
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: warningColor),
        borderRadius:
            const BorderRadius.all(Radius.circular(kBaseBorderRadius)),
      ),
      counterText: counterText,
      isDense: true,
    );
  }

  static InputDecoration textFieldFilledDecoration({
    required ThemeData theme,
    required Color warningColor,
    String hintText = '',
    IconData icon = Icons.person_outline,
    bool enabled = true,
    Color fillColor = Colors.white60,
    EdgeInsetsGeometry? padding,
    String? counterText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    var border = OutlineInputBorder(
      borderSide: BorderSide(color: fillColor),
      borderRadius: const BorderRadius.all(Radius.circular(kBaseBorderRadius)),
    );

    return InputDecoration(
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: padding,
      hintText: hintText,
      // hintStyle: TextStyle(color: fillColor),
      hintStyle: theme.textTheme.bodyLarge!.copyWith(color: fillColor),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      border: border,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: theme.primaryColor),
        borderRadius:
            const BorderRadius.all(Radius.circular(kBaseBorderRadius)),
      ),
      enabledBorder: border,
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: warningColor),
        borderRadius:
            const BorderRadius.all(Radius.circular(kBaseBorderRadius)),
      ),
      filled: true,
      fillColor: fillColor,
      // hoverColor: fillColor,
      focusColor: fillColor,
      counterText: counterText,
      isDense: true,
    );
  }

  static Widget progressIndicator({
    required color,
    size = 80,
    lineWidth = 4.0,
  }) {
    // return const CircularProgressIndicator();
    return SpinKitSpinningLines(
      color: color,
      size: size,
      lineWidth: lineWidth,
    );
  }

  static Widget miniProgressIndicator() {
    return Center(
      child: Container(
        height: kXXLargeIconSize,
        width: kXXLargeIconSize,
        padding: const EdgeInsets.all(kBasePadding),
        child: const CircularProgressIndicator(),
      ),
    );
  }

  static void showFlashSnackbar({
    required BuildContext context,
    required String snackBarType,
    String title = '',
    String message = 'This is an awesome snackbar!',
    EdgeInsets margin = const EdgeInsets.only(bottom: 8.0),
    double width = 350,
    double height = 80,
  }) {
    showFlash(
      context: context,
      persistent: true,
      duration: Duration(
        milliseconds: snackBarType == SnackBarType.failure ? 2500 : 2000,
      ),
      transitionDuration: const Duration(milliseconds: 300),
      builder: (_, controller) {
        return Flash(
          controller: controller,
          margin: margin,
          behavior: FlashBehavior.fixed,
          position: FlashPosition.bottom,
          // borderRadius: BorderRadius.circular(8.0),
          barrierDismissible: true,
          // borderColor: Colors.blue,
          // boxShadows: kElevationToShadow[8],
          constraints: BoxConstraints(maxWidth: width),
          backgroundColor: Colors.transparent,
          barrierColor: Colors.black.withOpacity(0.1),
          // backgroundGradient: RadialGradient(
          //   colors: [Colors.amber, Colors.black87],
          //   center: Alignment.topLeft,
          //   radius: 2,
          // ),
          onTap: () => controller.dismiss(),
          forwardAnimationCurve: Curves.easeIn,
          reverseAnimationCurve: Curves.easeOutQuad,
          child: SizedBox(
            width: width,
            height: height,
            child: CoolSnackbar(
              title: title,
              message: message,
              contentType: snackBarType,
              dismissible: false,
            ),
          ),
          // child: DefaultTextStyle(
          //   style: TextStyle(color: Colors.white),
          //   child: FlashBar(
          //     title: Text('Hello Flash'),
          //     content: Text('You can put any message of any length here.'),
          //     indicatorColor: Colors.red,
          //     icon: Icon(Icons.info_outline),
          //     primaryAction: TextButton(
          //       onPressed: () => controller.dismiss(),
          //       child: Text('DISMISS'),
          //     ),
          //     actions: <Widget>[
          //       TextButton(
          //           onPressed: () => controller.dismiss('Yes, I do!'),
          //           child: Text('YES')),
          //       TextButton(
          //           onPressed: () => controller.dismiss('No, I do not!'),
          //           child: Text('NO')),
          //     ],
          //   ),
          // ),
        );
      },
    ).then((_) {
      if (_ != null) {
        // _showMessage(_.toString());
      }
    });
  }

  static Widget shimmerBox({
    required ThemeData theme,
    Color? baseColor,
    Color? highlightColor,
    Color? color,
    double width = double.infinity,
    double height = kBaseIconSize,
  }) {
    final _baseColor = baseColor ?? Colors.grey.withOpacity(0.3);
    final _highlighColor = highlightColor ?? theme.canvasColor;
    final _color = color ?? Colors.white.withOpacity(0.3);

    return Shimmer.fromColors(
      baseColor: _baseColor,
      highlightColor: _highlighColor,
      child: Container(
        width: width,
        height: height,
        color: _color,
      ),
    );
  }
}
