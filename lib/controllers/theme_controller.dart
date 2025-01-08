import 'package:crypto_getx/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  Rx<ThemeData> currentTheme = lightTheme.obs;
  Rx<IconData> themeIcon = Icons.dark_mode_outlined.obs;

  void toggleTheme() {
    currentTheme.value =
        currentTheme.value == lightTheme ? darkTheme : lightTheme;
    themeIcon.value = themeIcon.value == Icons.dark_mode_outlined
        ? Icons.light_mode
        : Icons.dark_mode_outlined;
  }
}
