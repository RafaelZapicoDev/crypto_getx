import 'package:crypto_getx/controllers/assets_controller.dart';
import 'package:crypto_getx/models/api_response.dart';
import 'package:crypto_getx/services/http_service.dart';
import 'package:crypto_getx/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAssetDialogController extends GetxController {
  RxBool loading = false.obs;
  RxList<String> assets = <String>[].obs;
  RxString? selectedAsset = RxString("");
  RxDouble assetValue = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _getAssets();
  }

  Future<void> _getAssets() async {
    loading.value = true;
    HttpService httpService = Get.find<HttpService>();
    var responseData = await httpService.get("currencies");
    CurrenciesListAPIResponse currenciesListAPIResponse =
        CurrenciesListAPIResponse.fromJson(responseData);
    currenciesListAPIResponse.data?.forEach((coin) {
      assets.add(coin.name!);
    });

    // Define o valor inicial do selectedAsset
    if (assets.isNotEmpty) {
      selectedAsset?.value = assets.first;
    }

    loading.value = false;
  }
}

class AddAssetDialog extends StatelessWidget {
  final controller = Get.put(AddAssetDialogController());
  AddAssetDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Center(
        child: Material(
          child: Container(
            height: MediaQuery.sizeOf(context).height * 0.60,
            width: MediaQuery.sizeOf(context).height * 0.60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: _buildUi(context),
          ),
        ),
      ),
    );
  }

  Widget _buildUi(BuildContext context) {
    final double elementWidth = MediaQuery.sizeOf(context).width * 0.7;
    final double elementHeight = MediaQuery.sizeOf(context).width * 0.1;

    if (controller.loading.isTrue) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: elementWidth,
              height: elementHeight,
              child: const Text(
                "Select the current asset and owned value in your cripto wallet",
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              width: elementWidth,
              height: elementHeight,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  dropdownColor: Colors.white,
                  value: controller.selectedAsset?.value,
                  isExpanded: true,
                  items: controller.assets.map((asset) {
                    return DropdownMenuItem(
                      value: asset,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.amber,
                            ),
                          ),
                          Text(asset),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    controller.selectedAsset?.value = value!;
                  },
                  hint: const Text("Select an asset"),
                ),
              ),
            ),
            SizedBox(
              width: elementWidth,
              height: elementHeight,
              child: TextField(
                onChanged: (value) {
                  controller.assetValue.value = double.parse(value);
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "\$ 0.00",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              width: elementWidth,
              height: elementHeight,
              child: MaterialButton(
                onPressed: () {
                  AssetsController assetsController = Get.find();
                  assetsController.addTrackedAsset(
                    controller.selectedAsset!.value,
                    controller.assetValue!.value,
                  );
                  Get.back(closeOverlays: true);
                },
                color: Theme.of(context).colorScheme.primary,
                child: const Text(
                  "Add Asset",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
