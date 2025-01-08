import 'package:crypto_getx/controllers/assets_controller.dart';
import 'package:crypto_getx/controllers/theme_controller.dart';
import 'package:crypto_getx/models/tracked_asset.dart';
import 'package:crypto_getx/utils.dart';
import 'package:crypto_getx/widgets/add_asset_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  final AssetsController assetsController =
      Get.find(); //acha o controller das moedas
  final ThemeController themecontroller = Get.find();
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appbar(context),
      body: _buildUI(context),
    );
  }

  PreferredSizeWidget _appbar(BuildContext context) {
    return AppBar(
      title: const Text(
        "Simple Portfolio",
        style: TextStyle(letterSpacing: 1),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Get.dialog(AddAssetDialog());
          },
          icon: const Icon(Icons.add),
        ),
        Obx(
          () => IconButton(
            onPressed: () {
              themecontroller.toggleTheme();
            },
            icon: Icon(themecontroller.themeIcon.value),
          ),
        ),
      ],
    );
  }

  Widget _buildUI(BuildContext context) {
    return SafeArea(
        child: Obx(
      //observa as coi
      () => Column(
        children: [
          _portfolioValue(context), // valor total
          _trackedAssetsList(context), //moedas adicionadas na carteira
        ],
      ),
    ));
  }

  Widget _portfolioValue(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      margin: EdgeInsets.symmetric(
          vertical: MediaQuery.sizeOf(context).height * 0.03),
      child: Center(
        child: Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            children: [
              const TextSpan(
                text: "USD\$  ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text:
                    "${assetsController.getPortfolioValue().toStringAsFixed(2)} \n",
                style: const TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const TextSpan(
                text: "Total amount",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _trackedAssetsList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.05,
            child: const Text(
              "Portfolio",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.60,
            child: ListView.builder(
              itemCount: assetsController.trackedAssets.length,
              itemBuilder: (context, index) {
                TrackedAsset trackedAsset =
                    assetsController.trackedAssets[index];
                return ListTile(
                  leading: Image.network(
                    getCryptoImageUrl(trackedAsset.name!),
                    width: 35,
                    height: 35,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 35,
                        height: 35,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 255, 218, 7),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text(
                            '\$',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  title: Text(trackedAsset.name!),
                  subtitle: Text(
                    "USD: ${assetsController.getAssetPrice(trackedAsset.name!).toStringAsFixed(5)}",
                  ),
                  trailing: Text(
                    trackedAsset.amount.toString(),
                    style: const TextStyle(fontSize: 20),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
