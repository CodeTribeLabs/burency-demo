import 'package:flutter/material.dart';

class ThemeManager {
  static ThemeManager? _instance;

  ThemeManager._() {
    // Initialize TZ database
    // tz.initializeTimeZones();
  }

  factory ThemeManager.getInstance() {
    _instance ??= ThemeManager._();
    return _instance!;
  }

  late AppThemeData _appThemeData;

  void initThemeData() {
    _appThemeData = AppThemeData(
      primary: const Color(0xFFF39800),
      primaryDark: const Color(0xFFF39800),
      secondary: const Color(0xFF999999),
      secondaryDark: const Color(0xFF999999), // Color(0xFF2A3A55),
      accent: const Color(0xFF1baaec),
      accentDark: const Color(0xFFD56E2D),
      warning: const Color(0xFFD5153B),
      help: const Color(0xFF3282B8),
      failure: const Color(0xFFD5153B),
      success: const Color(0xFF12953A),
      information: const Color(0xFFFCA652),
      primaryText: const Color(0xFF181d28),
      primaryTextDark: const Color(0xFFFEFEFE),
      secondaryText: const Color(0xFF3E719A),
      secondaryTextDark: const Color(0xFFCCCCDD),
      captionText: const Color(0x7FFEFEFE),
      captionTextDark: const Color(0x7F3E719A),
      cardBackground: const Color(0xFFFAFAFA),
      cardBackgroundDark: const Color(0xFF181818),
      bodyBackground: const Color(0xFFFAFAFA),
      bodyBackgroundDark: const Color(0xFF181818),
    );
  }

  ThemeData loadThemeData({
    required BuildContext context,
    required bool darkMode,
  }) {
    final theme = Theme.of(context);

    final primaryColor = _appThemeData.primary;
    final primaryDarkColor = _appThemeData.primaryDark;
    final secondaryColor = _appThemeData.secondary;
    final secondaryDarkColor = _appThemeData.secondaryDark;
    final accentColor = _appThemeData.accent;
    final accentDarkColor = _appThemeData.accentDark;
    final cardColor = _appThemeData.cardBackground;
    final cardDarkColor = _appThemeData.cardBackgroundDark;

    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Montserrat',
      primaryColor: (darkMode) ? primaryDarkColor : primaryColor,
      focusColor: (darkMode) ? accentDarkColor : accentColor,
      hintColor: (darkMode) ? secondaryDarkColor : secondaryColor,
      scaffoldBackgroundColor: (darkMode)
          ? _appThemeData.bodyBackgroundDark
          : _appThemeData.bodyBackground,
      cardColor: (darkMode) ? cardDarkColor : cardColor,
      colorScheme: theme.colorScheme.copyWith(
        brightness: (darkMode) ? Brightness.dark : Brightness.light,
        primary: (darkMode) ? primaryDarkColor : primaryColor,
        secondary: (darkMode) ? primaryDarkColor : primaryColor,
      ),
      appBarTheme: theme.appBarTheme.copyWith(
        color: (darkMode) ? primaryDarkColor : primaryColor,
      ),
      textTheme: TextTheme(
        displayLarge: _getTextStyle(
          styleName: 'displayLarge',
          useDarkMode: darkMode,
        ),
        displayMedium: _getTextStyle(
          styleName: 'displayMedium',
          useDarkMode: darkMode,
        ),
        displaySmall: _getTextStyle(
          styleName: 'displaySmall',
          useDarkMode: darkMode,
        ),
        headlineLarge: _getTextStyle(
          styleName: 'headlineLarge',
          useDarkMode: darkMode,
        ),
        headlineMedium: _getTextStyle(
          styleName: 'headlineMedium',
          useDarkMode: darkMode,
        ),
        headlineSmall: _getTextStyle(
          styleName: 'headlineSmall',
          useDarkMode: darkMode,
        ),
        titleLarge: _getTextStyle(
          styleName: 'titleLarge',
          useDarkMode: darkMode,
        ),
        titleMedium: _getTextStyle(
          styleName: 'titleMedium',
          useDarkMode: darkMode,
        ),
        titleSmall: _getTextStyle(
          styleName: 'titleSmall',
          useDarkMode: darkMode,
        ),
        bodyLarge: _getTextStyle(
          styleName: 'bodyLarge',
          useDarkMode: darkMode,
        ),
        bodyMedium: _getTextStyle(
          styleName: 'bodyMedium',
          useDarkMode: darkMode,
        ),
        bodySmall: _getTextStyle(
          styleName: 'bodySmall',
          useDarkMode: darkMode,
        ),
      ),
    );
  }

  /// TextTheme migrated to 2018 specs: https://api.flutter.dev/flutter/material/TextTheme-class.html
  TextStyle _getTextStyle({
    required String styleName,
    required bool useDarkMode,
  }) {
    Color textColor =
        useDarkMode ? _appThemeData.primaryTextDark : _appThemeData.primaryText;

    switch (styleName) {
      case 'displayLarge':
        return TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.w300,
          color: textColor,
        );
      case 'displayMedium':
        return TextStyle(
          fontSize: 26.0,
          fontWeight: FontWeight.w300,
          color: textColor,
        );
      case 'displaySmall':
        return TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w300,
          color: textColor,
        );
      case 'headlineLarge':
        return TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w700,
          color: textColor,
        );
      case 'headlineMedium':
        return TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: textColor,
        );
      case 'headlineSmall':
        return TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: textColor,
        );
      case 'titleLarge':
        return TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: textColor,
        );
      case 'titleMedium':
        return TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w600,
          color: textColor,
        );
      case 'titleSmall':
        return TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: textColor,
        );
      case 'bodyLarge':
        return TextStyle(
          fontSize: 12.0,
          color: textColor,
        );
      case 'bodyMedium':
        return TextStyle(
          fontSize: 11.0,
          color: textColor,
        );
      case 'bodySmall':
        return TextStyle(
          fontSize: 10.0,
          color: textColor.withOpacity(0.5),
        );
      default:
        return TextStyle(
          fontSize: 10.0,
          color: textColor,
        );
    }
  }

  Color get warningColor => _appThemeData.warning;
  Color get helpColor => _appThemeData.help;
  Color get failureColor => _appThemeData.failure;
  Color get successColor => _appThemeData.success;
  Color get informationColor => _appThemeData.information;

  Color get accentColor => _appThemeData.accentDark;

  Color get primaryGradientDarkTone => _appThemeData.accentDark;
  Color get primaryGradientLightTone => _appThemeData.primary;

  static getUseDarkModeColors(bool useDarkMode, bool isEven) {
    if (useDarkMode == true) {
      return isEven ? const Color(0xFF0C0D12) : const Color(0xFF121318);
    } else {
      return isEven ? Colors.white : const Color(0xFFF4F4F4);
    }
  }
}

class AppThemeData {
  final Color primary;
  final Color primaryDark;
  final Color secondary;
  final Color secondaryDark;
  final Color accent;
  final Color accentDark;
  final Color warning;
  final Color help;
  final Color failure;
  final Color success;
  final Color information;
  final Color primaryText;
  final Color primaryTextDark;
  final Color secondaryText;
  final Color secondaryTextDark;
  final Color captionText;
  final Color captionTextDark;
  final Color cardBackground;
  final Color cardBackgroundDark;
  final Color bodyBackground;
  final Color bodyBackgroundDark;

  AppThemeData({
    required this.primary,
    required this.primaryDark,
    required this.secondary,
    required this.secondaryDark,
    required this.accent,
    required this.accentDark,
    required this.warning,
    required this.help,
    required this.failure,
    required this.success,
    required this.information,
    required this.primaryText,
    required this.primaryTextDark,
    required this.secondaryText,
    required this.secondaryTextDark,
    required this.captionText,
    required this.captionTextDark,
    required this.cardBackground,
    required this.cardBackgroundDark,
    required this.bodyBackground,
    required this.bodyBackgroundDark,
  });
}
