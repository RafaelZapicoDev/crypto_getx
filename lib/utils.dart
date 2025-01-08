import 'package:crypto_getx/controllers/assets_controller.dart';
import 'package:crypto_getx/controllers/theme_controller.dart';
import 'package:crypto_getx/services/http_service.dart';
import 'package:get/get.dart';

//metodos que serao utilizados em todo o codigo

Future<void> registerServices() async {
  // registra o service no getx
  Get.put<HttpService>(HttpService());
}

Future<void> registerControllers() async {
  Get.put<AssetsController>(
      AssetsController()); //registra o assetscontroller no getx
  Get.put<ThemeController>(
      ThemeController()); //registra o assetscontroller no getx
}

String getCryptoImageUrl(String name) {
  //retorna o icone da cryptomoeda
  return "https://raw.githubusercontent.com/ErikThiart/cryptocurrency-icons/master/128/${name.toLowerCase()}.png";
}
