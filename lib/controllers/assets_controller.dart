import 'package:crypto_getx/models/api_response.dart';
import 'package:crypto_getx/models/coin_data.dart';
import 'package:crypto_getx/models/tracked_asset.dart';
import 'package:crypto_getx/services/http_service.dart';
import 'package:get/get.dart';

//controller dos assets moedas
class AssetsController extends GetxController {
  //extende o getx controller que é registrado no utils,

  //dados a seres utilizados, com tratativa do getx , aqueles com .obs sao vigiados
  //pelos widgets obx, que atualizam sempre que o valor é alterado
  RxList<CoinData> coinData = <CoinData>[].obs;
  RxBool loading = false.obs;
  RxList<TrackedAsset> trackedAssets = <TrackedAsset>[].obs;

  @override //inicia o controller, pega os assets
  void onInit() {
    super.onInit();
    _getAssets();
  }

  void addTrackedAsset(String name, double amount) {
    //adiciona um novo asset a lista
    trackedAssets.add(
      TrackedAsset(
        name: name,
        amount: amount,
      ),
    );
  }

  Future<void> _getAssets() async {
    loading.value = true; //seta o carregando moedas como true
    HttpService httpService = Get.find(); //busca o service no getx
    var responseData = await httpService.get(
        "currencies"); // busca os tipos de moeda e seus dadfos na api utilizando o service
    CurrenciesListAPIResponse currenciesListAPIResponse =
        CurrenciesListAPIResponse.fromJson(responseData); //resposta da api
    coinData.value =
        currenciesListAPIResponse.data ?? []; //transforma em dados da moeda
    loading.value = false; // loading falso
  }

  double getPortfolioValue() {
    //calcula o valor total do portifolio
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
    //pega o preço do asset
    CoinData? data = getCoinData(name);
    return data?.values!.uSD?.price?.toDouble() ?? 0;
  }

  CoinData? getCoinData(String name) {
    //pega o asset pelo nome
    return coinData.firstWhereOrNull((e) => e.name == name);
  }
}
