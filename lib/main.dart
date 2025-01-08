import 'package:crypto_getx/controllers/theme_controller.dart';
import 'package:crypto_getx/pages/home.dart';
import 'package:crypto_getx/utils.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  await registerServices(); //registrando os componentes getx
  await registerControllers();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final themeController = Get.find<ThemeController>();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: themeController.currentTheme.value,
          routes: {
            "/home": (context) => Home(),
          },
          initialRoute: "/home",
        ));
  }
}
