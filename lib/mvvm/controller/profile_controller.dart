import '../const/export.dart';
import '../model/availability.dart';
import '../model/reviews.dart';

class ProfileController extends GetxController {
  final int? initialUserId;
  ProfileController({this.initialUserId});
  final ApiManager _apiManager = ApiManager();

  var isLoading = false.obs;

  /// Categories
  var userRoleList = <CategoryModel>[].obs;
  var selectedRoleId = RxnInt(); // nullable int
  var selectedRoleName = RxnString(); // for dropdown display

  /// Form controllers
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();

  final availability = Rxn<Availability>();
  final availabilityList = <Datum>[].obs;
  final isAvailable = false.obs;

  final userId = 0.obs;

  final rating = 0.0.obs; // example
  final reviews = Rxn<Reviews>();
  final ratingsList = <Rating>[].obs;

  final averageRating = 0.0.obs;
  final totalReviews = 0.obs;


  @override
  void onInit() {
    super.onInit();
    getServiceCategory();
    getAvailability();
    if (initialUserId != null) {
      // Use provided userId to fetch ratings directly
      getUserRating(initialUserId!);
    } else {
      // Fetch logged-in user info
      getUser();
    }
  }

  Future<void> getServiceCategory() async {
    try {
      var response = await _apiManager.read(ApiUrl.serviceCategory, false);
      print(StorageDesign.readItem(StorageDesign.token));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var categories = data['categories'] as List<dynamic>? ?? [];

        userRoleList.value = categories
            .map((e) => CategoryModel.fromJson(e))
            .toList();
      } else {
        var message = jsonDecode(response.body);
        CustomLoading.showNotification(
          message: message["error"]?["message"] ?? "Failed to fetch categories",
          messageType: MessageType.error,
        );
      }
    } catch (e) {
      CustomLoading.showNotification(
        message: e.toString(),
        messageType: MessageType.error,
      );
    }
  }

  Future<void> getAvailability() async {
    try {
      isLoading.value = true;

      final response =
      await _apiManager.read(ApiUrl.listAvailability, true);

      isLoading.value = false;

      if (response.statusCode == 200) {
        final result = availabilityFromJson(response.body);

        availability.value = result;
        availabilityList.assignAll(result.data ?? []);

        // OPTIONAL: backend may expose availability status
        // isAvailable.value = result.isAvailable == 1;

        print("📥 AVAILABILITY ITEMS: ${availabilityList.length}");
      } else {
        final message = jsonDecode(response.body);
        CustomLoading.showNotification(
          message:
          message["error"]?["message"] ?? "Failed to fetch availability",
          messageType: MessageType.error,
        );
      }
    } catch (e) {
      isLoading.value = false;
      CustomLoading.showNotification(
        message: e.toString(),
        messageType: MessageType.error,
      );
    }
  }

  Future<void> getUser() async {
    try {
      isLoading.value = true;

      final response = await _apiManager.read(ApiUrl.user, true);

      isLoading.value = false;

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final user = UserResponse.fromJson(json);

        userId.value = user.id;
        isAvailable.value = user.isAvailable;

        print("👤 USER ID: ${userId.value}");
        print("🟢 AVAILABLE: ${isAvailable.value}");

        // 🔥 NOW fetch rating
        await getUserRating(userId.value);
      } else {
        CustomLoading.showNotification(
          message: "Failed to fetch user",
          messageType: MessageType.error,
        );
      }
    } catch (e) {
      isLoading.value = false;
      CustomLoading.showNotification(
        message: e.toString(),
        messageType: MessageType.error,
      );
    }
  }

  Future<void> getUserRating(int userId) async {
    try {
      isLoading.value = true;

      final url = "v1/rating/$userId/user-rating";


      final response = await _apiManager.read(url, true);

      isLoading.value = false;

      if (response.statusCode == 200) {
        // 🔥 DECODE JSON (for readability)
        final decoded = jsonDecode(response.body);

        // ✅ Parse model
        final Reviews result = reviewsFromJson(response.body);

        reviews.value = result;
        ratingsList.assignAll(result.ratings ?? []);

        totalReviews.value = ratingsList.length;

        // ⭐ Calculate average rating
        if (ratingsList.isNotEmpty) {
          double sum = 0;
          for (final r in ratingsList) {
            sum += double.tryParse(r.stars ?? "0") ?? 0;
          }
          averageRating.value = sum / ratingsList.length;
        } else {
          averageRating.value = 0;
        }

        // Optional: print first review
        if (ratingsList.isNotEmpty) {
        }
      } else {
        CustomLoading.showNotification(
          message: "Failed to fetch rating",
          messageType: MessageType.error,
        );
      }
    } catch (e, stackTrace) {
      isLoading.value = false;

      CustomLoading.showNotification(
        message: e.toString(),
        messageType: MessageType.error,
      );
    }
  }

  Future<void> updateProfile() async {
    try {
      isLoading.value = true;

      final body = {
        "email": emailController.text.trim(),
        "username": usernameController.text.trim(),
        "phone": phoneController.text.trim(),
        "category_id": selectedRoleId.value,
      };

      final response = await _apiManager.post(ApiUrl.updateProfile, body, true);

      final message = jsonDecode(response.body);

      isLoading.value = false;
      print(StorageDesign.readItem(StorageDesign.token));

      if (response.statusCode == 200) {
        emailController.clear();
        usernameController.clear();
        phoneController.clear();
        selectedRoleId.value = 0;

        CustomLoading.showNotification(
          message: "Perfil atualizado com sucesso",
          messageType: MessageType.success,
        );
      } else {
        final errorMessage = message["error"]?["message"] ?? "Update failed";

        CustomLoading.showNotification(
          message: errorMessage,
          messageType: MessageType.error,
        );
      }
    } catch (e, stackTrace) {
      isLoading.value = false;


      CustomLoading.showNotification(
        message: e.toString(),
        messageType: MessageType.error,
      );
    }
  }

  Future<void> updateIsAvailability(bool value) async {
    try {
      isLoading.value = true;

      final body = {"is_available": value ? 1 : 0};

      final response = await _apiManager.post(
        ApiUrl.updateIsAvailability,
        body,
        true,
      );

      isLoading.value = false;

      final message = jsonDecode(response.body);

      if (response.statusCode == 200) {
        isAvailable.value = value; // 🔥 update local state

        CustomLoading.showNotification(
          message: "Disponibilidade atualizada com sucesso",
          messageType: MessageType.success,
        );
      } else {
        CustomLoading.showNotification(
          message: message["error"]?["message"] ?? "Update failed",
          messageType: MessageType.error,
        );
      }
    } catch (e) {
      isLoading.value = false;
      CustomLoading.showNotification(
        message: e.toString(),
        messageType: MessageType.error,
      );
    }
  }
}

class UserResponse {
  final int id;
  final bool isAvailable;

  UserResponse({
    required this.id,
    required this.isAvailable,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    final user = json["user"];
    final profile = user["profile"];

    return UserResponse(
      id: user["id"],
      isAvailable: profile["is_available"] == "1",
    );
  }
}
