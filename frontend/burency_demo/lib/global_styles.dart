import 'package:flutter/material.dart';

const kPrimaryText = Color(0xFF181d28); // Color(0xFFff7709);
const kPrimaryTextDark = Color(0xFFFeFeFe); //Color(0xFFe26a08);
const kSecondaryText = Color(0xFF3E719A); // Color(0xFF344968);
const kSecondaryTextDark = Color(0xFFccccdd);
const kCaptionText =
    Color.fromRGBO(24, 29, 40, 0.5); // kPrimaryText 0.5 opacity
const kCaptionyTextDark =
    Color.fromRGBO(254, 254, 254, 0.5); // kPrimaryDarkText 0.5 opacity

const kSecondaryGradientDark = Color.fromRGBO(203, 203, 203, 1);
const kSecondaryGradientLight = Color.fromRGBO(203, 203, 203, 1);
const kFocusGradientDark = Color.fromRGBO(34, 65, 90, 0.8);
const kFocusGradientLight = Color.fromRGBO(154, 218, 255, 0.60);

const kHeaderBackground = Color(0xFF29303f); //kBlueGray50
const kBodyBackground = Color(0xFF181d28);
const kPanelHeaderBackground = Color(0xFF2e374a); //kBlueGray75
const kPanelOddBackground = Color(0xFF1c212c); //kBlueGray200
const kPanelEvenBackground = kBodyBackground; //kBlueGray100
const kBorderStroke = Color(0xFF222834);

const kBlackGradientStart = Color.fromRGBO(85, 89, 92, 1);
const kBlackGradientEnd = Color.fromRGBO(53, 54, 59, 1);

const kBlueGray = Color(0xFF252b38);
const kGray300 = Color(0xFF757777);
const kGray500 = Color(0xFF383e4d);

const kBlue = Color(0xFF2b8efd);
const kRed = Color(0xFFef4239);
const kRedDT = Color(0xFFCB5F66);
const kYellow = Color(0xFFFEB51D); // Color(0xFFF9B00C);
const kOrange = Color(0xFFec9a5d);
const kGreen = Color.fromRGBO(89, 178, 108, 1.0); // Color(0xFF4aa83a);
const kDarkGreen = Color(0xFF12953A);
const kDarkOrange = Color(0xffD56E2D);

const kGoogleColor = Color(0xFF4081EC);
const kFacebookColor = Color(0xFF3b5998);
const kAppleColor = Color(0xFF666666);
const kGrey = Colors.grey;
const kLightGreen = Color(0xFFCAF0DB); // GrabLightGreen
const kLightRed = Color(0xFFFFDDDC); // GrabLightGreen
const kCommonBlack = Color(0xFF2C2C2C);

const kDisabledColorOpacity = 0.4;
const kScaleDown = 0.75;

const ColorFilter kGrayscale = ColorFilter.matrix(
  <double>[
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ],
);

const kBasePadding = 8.0;
const kBasePadding2 = kBasePadding * 2.0;
const kBasePadding3 = kBasePadding * 3.0;
const kBasePadding4 = kBasePadding * 4.0;
const kBasePadding5 = kBasePadding * 5.0;
const kBasePadding6 = kBasePadding * 6.0;
const kBasePadding7 = kBasePadding * 7.0;
const kBasePadding8 = kBasePadding * 8.0;
const kBasePadding9 = kBasePadding * 9.0;
const kBasePadding10 = kBasePadding * 10.0;
const kMiniSpacing = 2.0;
const kMiniSpacing2 = 4.0;
const kBaseSpacing = 5.0;
const kBaseSpacing2 = 10.0;

const kBaseMargin = 2.0;
const kBaseMargin2 = 4.0;
const kBaseMargin3 = 6.0;
const kBaseMargin4 = 8.0;
const kBaseMargin5 = 10.0;

const kBaseButtonFont = 14.0;
const kLargeFont = 24.0;
const kxLargeFont = 28.0;
const kxxLargeFont = 30.0;

const kBaseButtonHeight = 60.0;
const kBaseButtonPadding = EdgeInsets.symmetric(
  horizontal: kBasePadding3,
  vertical: kBasePadding * 0.5,
);
const kBlockButtonPadding = EdgeInsets.symmetric(
  horizontal: kBasePadding4,
  vertical: kBasePadding * 1.5,
);
const kBaseDividerHeight = kBasePadding;

const kMiniBorderRadius = kBasePadding * 0.5;
const kBaseBorderRadius = kBasePadding;
const kBaseBorderRadius2 = kBaseBorderRadius * 2;
const kBaseBorderRadius3 = kBaseBorderRadius * 3;
const kBaseBorderRadius4 = kBaseBorderRadius * 4;
const kBaseBorderRadius5 = kBaseBorderRadius * 5;
const kBigBorderRadius = 30.0;

const kMiniAvatarSize = 42.0;
const kBaseAvatarSize = 60.0;
const kBigAvatarSize = 80.0;

const kMicroIconSize = 16.0;
const kTinyIconSize = 18.0;
const kMiniIconSize = 20.0;
const kSmallIconSize = 22.0;
const kBaseIconSize = 24.0;
const kMiniButtonIconSize = 26.0;
const kMediumIconSize = 28.0;
const kBigIconSize = 30.0;
const kButtonIconSize = 32.0;
const kLargeIconSize = 36.0;
const kXLargeIconSize = 42.0;
const kXXLargeIconSize = 48.0;
const kXXXLargeIconSize = 64.0;
const kSuperLargeIconSize = 80.0;

const kListIconSize = 48.0;

const String kSymbolFontFamily = 'Roboto';
const String kSymbolCurrencyPhp = '\u20B1';
const String kSymbolBullet = '\u2022';
const String kSymbolDegree = '°'; //0x00B0
const String kSymbolCopyright = '©';
