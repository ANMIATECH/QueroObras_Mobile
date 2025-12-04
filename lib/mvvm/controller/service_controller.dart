import '../const/export.dart';

class ServiceController extends GetxController {
  final ApiManager _apiManager = ApiManager();
  RxList<dynamic> categories = <dynamic>[].obs;
  RxList<dynamic> cCategories = <dynamic>[].obs;
  RxList<dynamic> aCategories = <dynamic>[].obs;
  RxList providers = [].obs;
  var categoryName = ''.obs;
  RxList filteredProviders = [].obs;

  RxDouble myLat = 0.0.obs;
  RxDouble myLng = 0.0.obs;

  Future<void> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    myLat.value = position.latitude;
    myLng.value = position.longitude;
  }


  Future<double> calculateDistance(
      double startLat,
      double startLng,
      double endLat,
      double endLng,
      ) async {
    return Geolocator.distanceBetween(startLat, startLng, endLat, endLng) / 1000; // km
  }


  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getPopularServiceProvider();
    getCurrentLocation();
    getConstructionServiceProvider();
    getAcabamentoServiceProvider();
  }
  @override
  void onClose() {
  }

  Future<void> getPopularServiceProvider() async {
    try {
      var response = await _apiManager.read(ApiUrl.popularCategory, false);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        categories.value = data["categories"] ?? [];
      } else {
        var message = jsonDecode(response.body);
        var error =
            message["error"]?["message"] ?? "Failed to fetch categories";

        SnackbarUtil.showSnackbar(
          title: "Fetch Failed",
          message: error,
          type: SnackbarType.error,
        );
      }
    } catch (e) {
      SnackbarUtil.showSnackbar(
        title: "Error",
        message: e.toString(),
        type: SnackbarType.error,
      );
    }
  }

  Future<void> getConstructionServiceProvider() async {
    try {
      var response = await _apiManager.read(ApiUrl.constructionCategory, false);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        cCategories.value = data["categories"] ?? [];
      } else {
        var message = jsonDecode(response.body);
        var error =
            message["error"]?["message"] ?? "Failed to fetch categories";

        SnackbarUtil.showSnackbar(
          title: "Fetch Failed",
          message: error,
          type: SnackbarType.error,
        );
      }
    } catch (e) {
      SnackbarUtil.showSnackbar(
        title: "Error",
        message: e.toString(),
        type: SnackbarType.error,
      );
    }
  }

  Future<void> getAcabamentoServiceProvider() async {
    try {

      var response = await _apiManager.read(ApiUrl.acabamentoCategory, false);




      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        aCategories.value = data["categories"] ?? [];

      } else {
        var message = jsonDecode(response.body);
        var error =
            message["error"]?["message"] ?? "Failed to fetch categories";

        SnackbarUtil.showSnackbar(
          title: "Fetch Failed",
          message: error,
          type: SnackbarType.error,
        );
      }
    } catch (e) {
      SnackbarUtil.showSnackbar(
        title: "Error",
        message: e.toString(),
        type: SnackbarType.error,
      );
    }
  }

  Future<void> getPopularServiceProviderBySlug(String slug) async {
    try {

      final url = "v1/category/$slug/users";

      var response = await _apiManager.read(url, false);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        providers.value = data["users"] ?? [];
        filteredProviders.value = List.from(providers);

        categoryName.value = data["category"]?["name"] ?? "";
      } else {
        var message = jsonDecode(response.body);
        var error =
            message["error"]?["message"] ?? "Failed to fetch providers";

        SnackbarUtil.showSnackbar(
          title: "Fetch Failed",
          message: error,
          type: SnackbarType.error,
        );
      }
    } catch (e) {
      SnackbarUtil.showSnackbar(
        title: "Error",
        message: e.toString(),
        type: SnackbarType.error,
      );
    }
  }

  // 🔎 Search filter
  void filterProviders(String query) {
    if (query.isEmpty) {
      filteredProviders.value = providers;
    } else {
      filteredProviders.value = providers.where((provider) {
        final name = (provider['name'] ?? '').toString().toLowerCase();
        return name.contains(query.toLowerCase());
      }).toList();
    }
  }
}
