import 'package:crypto_getx/controllers/assets_controller.dart';
import 'package:crypto_getx/services/http_service.dart';
import 'package:get/get.dart';

Future<void> registerServices() async {
  Get.put<HttpService>(HttpService());
}

Future<void> registerControllers() async {
  Get.put<AssetsController>(AssetsController());
}

String getCryptoImageUrl(String name) {
  return "https://raw.githubusercontent.com/ErikThiart/cryptocurrency-icons/master/128/${name.toLowerCase()}.png";
}
