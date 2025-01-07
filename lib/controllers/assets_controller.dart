import 'package:crypto_getx/models/api_response.dart';
import 'package:crypto_getx/models/coin_data.dart';
import 'package:crypto_getx/models/tracked_asset.dart';
import 'package:crypto_getx/services/http_service.dart';
import 'package:get/get.dart';

class AssetsController extends GetxController {
  RxList<CoinData> coinData = <CoinData>[].obs;
  RxBool loading = false.obs;
  RxList<TrackedAsset> trackedAssets = <TrackedAsset>[].obs;

  @override
  void onInit() {
    super.onInit();
    _getAssets();
  }

  void addTrackedAsset(String name, double amount) {
    trackedAssets.add(
      TrackedAsset(
        name: name,
        amount: amount,
      ),
    );
  }

  Future<void> _getAssets() async {
    loading.value = true;
    HttpService httpService = Get.find();
    var responseData = await httpService.get("currencies");
    CurrenciesListAPIResponse currenciesListAPIResponse =
        CurrenciesListAPIResponse.fromJson(responseData);
    coinData.value = currenciesListAPIResponse.data ?? [];
    loading.value = false;
  }

  double getPortfolioValue() {
    if (trackedAssets.isEmpty) {
      return 0;
    }
    if (coinData.isEmpty) {
      return 0;
    }
    double value = 0;
    for (TrackedAsset asset in trackedAssets) {
      value += getAssetPrice(asset.name!) * asset.amount!;
    }
    return value;
  }

  double getAssetPrice(String name) {
    CoinData? data = getCoinData(name);
    return data?.values!.uSD?.price?.toDouble() ?? 0;
  }

  CoinData? getCoinData(String name) {
    return coinData.firstWhereOrNull((e) => e.name == name);
  }
}
