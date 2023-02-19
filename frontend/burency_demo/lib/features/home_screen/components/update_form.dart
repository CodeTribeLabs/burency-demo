import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:burency_demo/_core/controllers/contacts_controller.dart';
import 'package:burency_demo/_core/app_widget_builder.dart';
import 'package:burency_demo/_core/models/contact_model.dart';

import 'package:burency_demo/theme.dart';
import 'package:burency_demo/global_styles.dart';
import 'package:burency_demo/_ui/buttons/primary_button.dart';
import 'package:burency_demo/_ui/buttons/secondary_button.dart';
import 'package:burency_demo/_ui/modals/cool_snackbar.dart';
import 'package:burency_demo/_ui/modals/screen_locker.dart';

class UpdateForm extends StatefulWidget {
  final ContactModel? contact;

  const UpdateForm({
    Key? key,
    this.contact,
  }) : super(key: key);

  @override
  _UpdateFormState createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateForm> with TickerProviderStateMixin {
  // static const String moduleName = 'UpdateForm';

  final GlobalKey<FormState> _formKey = GlobalKey();
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _noteController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();

  final ContactsController _contactsController = Get.find();

  final ContactModel _contact = ContactModel();

  @override
  void initState() {
    super.initState();

    final contact = widget.contact;
    if (contact != null) {
      _firstNameController.text = contact.firstName;
      _middleNameController.text = contact.middleName;
      _lastNameController.text = contact.lastName;
      _addressController.text = contact.address;
      _phoneController.text = contact.phone;
      _noteController.text = contact.note;
      _latitudeController.text = contact.latitude.toString();
      _longitudeController.text = contact.longitude.toString();

      _contact.id = contact.id;
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _noteController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();

    super.dispose();
  }

  Future<void> _submit(ThemeData theme) async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }

    _formKey.currentState!.save();

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const ScreenLocker();
      },
    );

    String resp = '';

    if (_isUpdate) {
      resp = await _contactsController.updateContact(contact: _contact);
    } else {
      resp = await _contactsController.addContact(contact: _contact);
    }

    Get.back();

    if (resp.isEmpty) {
      Get.back();
      AppWidgetBuilder.showFlashSnackbar(
        context: context,
        snackBarType: SnackBarType.success,
        title: _isUpdate ? 'That went well!'.tr : 'Awesome!'.tr,
        message: _isUpdate
            ? 'Contact updated successfuly'.tr
            : 'You have added a new contact'.tr,
      );
    } else {
      AppWidgetBuilder.showFlashSnackbar(
        context: context,
        snackBarType: SnackBarType.failure,
        title: 'Aww Snap!'.tr,
        message: resp.tr,
      );
    }
  }

  bool get _isUpdate => widget.contact != null && widget.contact!.id.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeManager = ThemeManager.getInstance();

    const iconPadding = EdgeInsets.symmetric(
      horizontal: 0,
      vertical: 0,
    );

    const double fieldWidth = 360;
    const double fieldHeight = 70;

    const double iconSize = kMiniIconSize;
    final Color iconColor = themeManager.accentColor;

    final nameFormatter = [
      FilteringTextInputFormatter(
        RegExp(r'[a-zA-Z- ]'),
        allow: true,
      )
    ];

    final phoneFormatter = [
      FilteringTextInputFormatter(
        RegExp(r'[0-9+-]'),
        allow: true,
      )
    ];

    final numericFormatter = [
      FilteringTextInputFormatter(
        RegExp(r'[0-9.]'),
        allow: true,
      )
    ];

    return Dialog(
      backgroundColor: theme.cardColor,
      surfaceTintColor: theme.cardColor,
      child: Padding(
        padding: const EdgeInsets.all(kBasePadding2),
        child: Column(
          children: [
            Text(
              _isUpdate ? 'Edit Contact' : 'New Contact',
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: kBasePadding2),
            Expanded(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: fieldWidth,
                          minHeight: fieldHeight,
                        ),
                        child: TextFormField(
                          controller: _firstNameController,
                          decoration:
                              AppWidgetBuilder.textFieldFilledDecoration(
                            theme: theme,
                            warningColor: themeManager.warningColor,
                            hintText: 'First Name'.tr,
                            prefixIcon: Padding(
                              padding: iconPadding,
                              child: Icon(
                                Icons.account_circle,
                                size: iconSize,
                                color: iconColor,
                              ),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.emailAddress,
                          inputFormatters: nameFormatter,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'First Name is required'.tr;
                            }

                            return null;
                          },
                          onSaved: (value) {
                            _contact.firstName = value!;
                          },
                        ),
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: fieldWidth,
                          minHeight: fieldHeight,
                        ),
                        child: TextFormField(
                          controller: _middleNameController,
                          decoration:
                              AppWidgetBuilder.textFieldFilledDecoration(
                            theme: theme,
                            warningColor: themeManager.warningColor,
                            hintText: 'Middle Name'.tr,
                            prefixIcon: Padding(
                              padding: iconPadding,
                              child: Icon(
                                Icons.account_circle,
                                size: iconSize,
                                color: iconColor,
                              ),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.emailAddress,
                          inputFormatters: nameFormatter,
                          validator: (value) {
                            return null;
                          },
                          onSaved: (value) {
                            _contact.middleName = value!;
                          },
                        ),
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: fieldWidth,
                          minHeight: fieldHeight,
                        ),
                        child: TextFormField(
                          controller: _lastNameController,
                          decoration:
                              AppWidgetBuilder.textFieldFilledDecoration(
                            theme: theme,
                            warningColor: themeManager.warningColor,
                            hintText: 'Last Name'.tr,
                            prefixIcon: Padding(
                              padding: iconPadding,
                              child: Icon(
                                Icons.account_circle,
                                size: iconSize,
                                color: iconColor,
                              ),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.emailAddress,
                          inputFormatters: nameFormatter,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Last Name is required'.tr;
                            }

                            return null;
                          },
                          onSaved: (value) {
                            _contact.lastName = value!;
                          },
                        ),
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: fieldWidth,
                          minHeight: fieldHeight,
                        ),
                        child: TextFormField(
                          controller: _phoneController,
                          decoration:
                              AppWidgetBuilder.textFieldFilledDecoration(
                            theme: theme,
                            warningColor: themeManager.warningColor,
                            hintText: 'Phone'.tr,
                            prefixIcon: Padding(
                              padding: iconPadding,
                              child: Icon(
                                Icons.phone,
                                size: iconSize,
                                color: iconColor,
                              ),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.phone,
                          inputFormatters: phoneFormatter,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Phone is required'.tr;
                            }

                            return null;
                          },
                          onSaved: (value) {
                            _contact.phone = value!;
                          },
                        ),
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: fieldWidth,
                          minHeight: fieldHeight,
                        ),
                        child: TextFormField(
                          controller: _addressController,
                          decoration:
                              AppWidgetBuilder.textFieldFilledDecoration(
                            theme: theme,
                            warningColor: themeManager.warningColor,
                            hintText: 'Address'.tr,
                            prefixIcon: Padding(
                              padding: iconPadding,
                              child: Icon(
                                Icons.home,
                                size: iconSize,
                                color: iconColor,
                              ),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            return null;
                          },
                          onSaved: (value) {
                            //_authData.email = value!;
                            _contact.address = value!;
                          },
                        ),
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: fieldWidth,
                          minHeight: fieldHeight,
                        ),
                        child: TextFormField(
                          controller: _noteController,
                          decoration:
                              AppWidgetBuilder.textFieldFilledDecoration(
                            theme: theme,
                            warningColor: themeManager.warningColor,
                            hintText: 'Note'.tr,
                            prefixIcon: Padding(
                              padding: iconPadding,
                              child: Icon(
                                Icons.note,
                                size: iconSize,
                                color: iconColor,
                              ),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            return null;
                          },
                          onSaved: (value) {
                            _contact.note = value!;
                          },
                        ),
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: fieldWidth,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _latitudeController,
                                decoration:
                                    AppWidgetBuilder.textFieldFilledDecoration(
                                  theme: theme,
                                  warningColor: themeManager.warningColor,
                                  hintText: 'Latitude'.tr,
                                  prefixIcon: Padding(
                                    padding: iconPadding,
                                    child: Icon(
                                      Icons.place,
                                      size: iconSize,
                                      color: iconColor,
                                    ),
                                  ),
                                ),
                                style: const TextStyle(color: Colors.white),
                                cursorColor: Colors.white,
                                keyboardType: TextInputType.number,
                                inputFormatters: numericFormatter,
                                validator: (value) {
                                  return null;
                                },
                                onSaved: (value) {
                                  _contact.latitude =
                                      double.tryParse(value!) ?? 0;
                                },
                              ),
                            ),
                            AppWidgetBuilder.horizontalSpacer(
                              width: kBasePadding,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: _longitudeController,
                                decoration:
                                    AppWidgetBuilder.textFieldFilledDecoration(
                                  theme: theme,
                                  warningColor: themeManager.warningColor,
                                  hintText: 'Longitude'.tr,
                                  prefixIcon: Padding(
                                    padding: iconPadding,
                                    child: Icon(
                                      Icons.place,
                                      size: iconSize,
                                      color: iconColor,
                                    ),
                                  ),
                                ),
                                style: const TextStyle(color: Colors.white),
                                cursorColor: Colors.white,
                                keyboardType: TextInputType.number,
                                inputFormatters: numericFormatter,
                                validator: (value) {
                                  return null;
                                },
                                onSaved: (value) {
                                  _contact.longitude =
                                      double.tryParse(value!) ?? 0;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: kBasePadding2),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: fieldWidth),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SecondaryButton(
                      onPressed: () => Get.back(),
                      label: 'Cancel'.tr.toUpperCase(),
                    ),
                  ),
                  AppWidgetBuilder.horizontalSpacer(
                    width: kBasePadding,
                  ),
                  Expanded(
                    child: PrimaryButton(
                      onPressed: () => _submit(theme),
                      label: (_isUpdate ? 'Update' : 'Create').tr.toUpperCase(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
