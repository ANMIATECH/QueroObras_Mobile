import '../const/export.dart';

class ServiceController extends GetxController {
  final ApiManager _apiManager = ApiManager();
  RxList<dynamic> categories = <dynamic>[].obs;



  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getPopularServiceProvider();
  }
  @override
  void onClose() {
  }

  Future<void> getPopularServiceProvider() async {
    try {
      print("📡 Fetching service categories...");
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
}
