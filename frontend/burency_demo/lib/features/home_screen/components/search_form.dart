import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:burency_demo/_core/app_widget_builder.dart';
import 'package:burency_demo/_core/controllers/contacts_controller.dart';
import 'package:burency_demo/_ui/buttons/primary_mini_button.dart';

import 'package:burency_demo/theme.dart';
import 'package:burency_demo/global_styles.dart';

class SearchForm extends StatefulWidget {
  final String uid;
  final bool searchNearby;

  const SearchForm({
    super.key,
    required this.uid,
    this.searchNearby = false,
  });

  @override
  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _keywordController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();
  final _radiusController = TextEditingController();

  final ContactsController _contactsController = Get.find();

  String _query = '';
  double? _latitude;
  double? _longitude;
  int? _radiusInMeters;
  bool _searchNearby = false;

  @override
  void initState() {
    super.initState();

    _searchNearby = widget.searchNearby;
  }

  @override
  void dispose() {
    _keywordController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    _radiusController.dispose();

    super.dispose();
  }

  Future<void> _submit(ThemeData theme) async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }

    _formKey.currentState!.save();

    Get.back();

    await _contactsController.fetch(
      widget.uid,
      searchNearby: _searchNearby,
      query: _query,
      latitude: _latitude,
      longitude: _longitude,
      radiusInMeters: _radiusInMeters != null ? _radiusInMeters! * 1000 : null,
    );
  }

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

    final numericFormatter = [
      FilteringTextInputFormatter(
        RegExp(r'[0-9.]'),
        allow: true,
      )
    ];

    return Container(
      padding: const EdgeInsets.all(kBasePadding),
      height: _searchNearby ? 180 : 380,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            _searchNearby ? 'People Nearby' : 'Search Contact'.tr,
            style: theme.textTheme.labelLarge!.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: kBasePadding2),
          Expanded(
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!_searchNearby) ...[
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: fieldWidth,
                          minHeight: fieldHeight,
                        ),
                        child: TextFormField(
                          controller: _keywordController,
                          decoration:
                              AppWidgetBuilder.textFieldFilledDecoration(
                            theme: theme,
                            warningColor: themeManager.warningColor,
                            hintText: 'Enter search term'.tr,
                            prefixIcon: Padding(
                              padding: iconPadding,
                              child: Icon(
                                Icons.manage_search,
                                size: iconSize,
                                color: iconColor,
                              ),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            return null;
                          },
                          onSaved: (value) {
                            _query = value!;
                          },
                        ),
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: fieldWidth,
                          minHeight: fieldHeight,
                        ),
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
                            _latitude = value!.isNotEmpty
                                ? double.tryParse(value)
                                : null;
                          },
                        ),
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: fieldWidth,
                          minHeight: fieldHeight,
                        ),
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
                            _longitude = value!.isNotEmpty
                                ? double.tryParse(value)
                                : null;
                          },
                        ),
                      ),
                    ],
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: fieldWidth,
                        minHeight: fieldHeight,
                      ),
                      child: TextFormField(
                        controller: _radiusController,
                        decoration: AppWidgetBuilder.textFieldFilledDecoration(
                          theme: theme,
                          warningColor: themeManager.warningColor,
                          hintText: 'Distance (km)'.tr,
                          prefixIcon: Padding(
                            padding: iconPadding,
                            child: Icon(
                              Icons.location_searching,
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
                          _radiusInMeters =
                              value!.isNotEmpty ? int.tryParse(value) : null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 90),
            child: Row(
              children: [
                Expanded(
                  child: PrimaryMiniButton(
                    label: 'Search'.tr.toUpperCase(),
                    onPressed: () => _submit(theme),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      // color: Colors.grey,
    );
  }
}
