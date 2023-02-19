import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:burency_demo/_core/app_widget_builder.dart';
import 'package:burency_demo/_core/controllers/auth_controller.dart';

import 'package:burency_demo/theme.dart';
import 'package:burency_demo/global_styles.dart';
import 'package:burency_demo/_ui/buttons/primary_button.dart';
import 'package:burency_demo/_ui/buttons/primary_text_button.dart';
import 'package:burency_demo/_ui/modals/cool_snackbar.dart';

class LoginForm extends StatefulWidget {
  final VoidCallback onComplete;
  final VoidCallback onCancel;

  const LoginForm({
    Key? key,
    required this.onComplete,
    required this.onCancel,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> with TickerProviderStateMixin {
  // static const String moduleName = 'LoginForm';

  final GlobalKey<FormState> _formKey = GlobalKey();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final AuthFormModel _authData = AuthFormModel();
  late AuthController _authController;

  bool _passwordHidden = true;

  @override
  void initState() {
    super.initState();

    _authController = Get.find();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitLogin(ThemeData theme) async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }

    _formKey.currentState!.save();

    final result = await _authController.signInWithEmail(
      email: _authData.email,
      password: _authData.password,
    );

    if (!result.isSuccessful) {
      AppWidgetBuilder.showFlashSnackbar(
        context: context,
        snackBarType: SnackBarType.failure,
        title: 'Aww Snap!'.tr,
        message: result.message!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeManager = ThemeManager.getInstance();

    const iconColor = Colors.white;

    const obscureIconOff = Icon(
      FontAwesomeIcons.eye,
      color: iconColor,
    );
    const obscureIconOn = Icon(
      FontAwesomeIcons.eyeSlash,
      color: iconColor,
    );

    const padding = EdgeInsets.symmetric(
      horizontal: kBasePadding,
      vertical: kBasePadding,
    );

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Welcome to Burency Demo'.tr,
            style: theme.textTheme.headlineSmall!.copyWith(
              color: Colors.white,
            ),
          ),
          AppWidgetBuilder.verticalSpacer(height: kBasePadding4),
          TextFormField(
            controller: _emailController,
            decoration: AppWidgetBuilder.textFieldFilledDecoration(
              theme: theme,
              warningColor: themeManager.warningColor,
              hintText: 'Email'.tr,
              prefixIcon: Padding(
                padding: padding,
                child: Icon(
                  Icons.account_circle,
                  size: kBaseIconSize,
                  color: themeManager.accentColor,
                ),
              ),
            ),
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Username is required'.tr;
              }

              return null;
            },
            onSaved: (value) {
              _authData.email = value!;
            },
          ),
          AppWidgetBuilder.verticalSpacer(height: kBasePadding2),
          TextFormField(
            controller: _passwordController,
            decoration: AppWidgetBuilder.textFieldFilledDecoration(
              theme: theme,
              warningColor: themeManager.warningColor,
              hintText: 'Password'.tr,
              prefixIcon: Padding(
                padding: padding,
                child: Icon(
                  Icons.lock,
                  size: kBaseIconSize,
                  color: themeManager.accentColor,
                ),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kBasePadding,
                ),
                child: IconButton(
                  splashRadius: kMiniIconSize,
                  onPressed: () {
                    setState(() {
                      _passwordHidden = !_passwordHidden;
                    });
                  },
                  icon: _passwordHidden ? obscureIconOff : obscureIconOn,
                ),
              ),
              counterText: '',
            ),
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            obscureText: _passwordHidden,
            maxLength: 20,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Password is required'.tr;
              }

              return null;
            },
            onSaved: (value) {
              _authData.password = value!;
            },
          ),
          AppWidgetBuilder.verticalSpacer(height: kBasePadding4),
          PrimaryButton(
            onPressed: () => _submitLogin(theme),
            label: 'Login'.tr.toUpperCase(),
          ),
          AppWidgetBuilder.verticalSpacer(height: kBasePadding4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'No account yet?'.tr,
                style: theme.textTheme.titleMedium!.copyWith(
                  color: Colors.white,
                ),
              ),
              PrimaryTextButton(
                label: 'Register'.tr.toUpperCase(),
                onPressed: () => _authController.toggleLoginMode(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
