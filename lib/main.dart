import 'package:crypto_getx/pages/home.dart';
import 'package:crypto_getx/utils.dart';
import 'package:crypto_getx/controllers/assets_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  await registerServices();
  await registerControllers();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
        textTheme: GoogleFonts.lilitaOneTextTheme(),
      ),
      routes: {
        "/home": (context) => Home(),
      },
      initialRoute: "/home",
    );
  }
}
