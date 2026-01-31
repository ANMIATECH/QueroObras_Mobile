import '../const/export.dart';
import '../model/availability.dart';
import '../model/reviews.dart';

class ProfileController extends GetxController {
  final int? initialUserId;
  ProfileController({this.initialUserId});
  final ApiManager _apiManager = ApiManager();

  var isLoading = false.obs;
  var selectedRolesNames = <String>[].obs;

  // For storing the IDs corresponding to the selected names
  var selectedRoleStatusIds = <int>[].obs;
  /// Categories
  var userRoleList = <CategoryModel>[].obs;
  var selectedRoleStatus = 0.obs; // RxInt
  var selectedRoleId = RxnInt();
  var selectedRoleName = RxnString();

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

  final userName = ''.obs;
  final userAvatar = ''.obs;
  final userAddress = ''.obs;
  final categoryId = ''.obs;

// Inside ProfileController
  RxString get userCategoryName {
    final id = int.tryParse(categoryId.value) ?? 0;
    final category = userRoleList.firstWhere(
          (c) => c.id == id,
      orElse: () => CategoryModel(id: 0, name: "Unknown"),
    );
    return category.name.obs;
  }

  // Store all days with their toggle & time state
  RxList<AvailabilityUI> days = <AvailabilityUI>[
    AvailabilityUI(uiDay: 'SEGUNDA-FEIRA', apiDay: 'segunda'),
    AvailabilityUI(uiDay: 'TERÇA-FEIRA', apiDay: 'terça'),
    AvailabilityUI(uiDay: 'QUARTA-FEIRA', apiDay: 'quarta'),
    AvailabilityUI(uiDay: 'QUINTA-FEIRA', apiDay: 'quinta'),
    AvailabilityUI(uiDay: 'SEXTA-FEIRA', apiDay: 'sexta'),
    AvailabilityUI(uiDay: 'SÁBADO', apiDay: 'sábado'),
    AvailabilityUI(uiDay: 'DOMINGO', apiDay: 'domingo'),
  ].obs;

  // Optionally: method to load saved availability from API
  void loadAvailability(List<AvailabilityUI> loadedDays) {
    days.assignAll(loadedDays);
  }


  @override
  void onInit() {
    super.onInit();
    getServiceCategory();
    getUserP();
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
      if (StorageDesign.validKey(StorageDesign.token) == false) {
      return;
    }
    try {
      var response = await _apiManager.read(ApiUrl.serviceCategory, false);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var categories = data['categories'] as List<dynamic>? ?? [];

        userRoleList.value = categories
            .map((e) => CategoryModel.fromJson(e))
            .toList();
      } else {
        // var message = jsonDecode(response.body);
        // CustomLoading.showNotification(
        //   message: message["error"]?["message"] ?? "Falha ao buscar categorias",
        //   messageType: MessageType.error,
        // );
      }
    } catch (e) {
      CustomLoading.showNotification(
        message: e.toString(),
        messageType: MessageType.error,
      );
    }
  }

  Future<void> getServiceCategory1() async {
      if (StorageDesign.validKey(StorageDesign.token) == false) {
      return;
    }
    try {
      var response = await _apiManager.read(ApiUrl.serviceCategory, false);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var categories = data['categories'] as List<dynamic>? ?? [];

        userRoleList.value =
            categories.map((e) => CategoryModel.fromJson(e)).toList();
      } else {
        var message = jsonDecode(response.body);
        CustomLoading.showNotification(
          message: message["error"]?["message"] ?? "Falha ao buscar categorias",

          messageType: MessageType.error,
        );
      }
    } catch (e) {
      // CustomLoading.showNotification(
      //   message: e.toString(),
      //   messageType: MessageType.error,
      // );
    }
  }

  Future<void> getAvailability() async {
      if (StorageDesign.validKey(StorageDesign.token) == false) {
      return;
    }
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

        // print("📥 AVAILABILITY ITEMS: ${availabilityList.length}");
      } else {
        final message = jsonDecode(response.body);
        CustomLoading.showNotification(
          message: message["error"]?["message"] ?? "Falha ao buscar disponibilidade",
          messageType: MessageType.error,
        );
      }
    } catch (e) {
      isLoading.value = false;
      // CustomLoading.showNotification(
      //   message: e.toString(),
      //   messageType: MessageType.error,
      // );
    }
  }

  Future<void> getUser() async { 
      if (StorageDesign.validKey(StorageDesign.token) == false) {
      return;
    }
    try {

      final response = await _apiManager.read(ApiUrl.user, true);


      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final user = UserResponse.fromJson(json);

        userId.value = user.id;
        isAvailable.value = user.isAvailable;

        // print("👤 USER ID: ${userId.value}");
        // print("🟢 AVAILABLE: ${isAvailable.value}");

        // 🔥 NOW fetch rating
        await getUserRating(userId.value);
      } else {
        CustomLoading.showNotification(
          message: "Falha ao buscar usuário",
          messageType: MessageType.error,
        );
      }
    } catch (e) {
      // CustomLoading.showNotification(
      //   message: e.toString(),
      //   messageType: MessageType.error,
      // );
    }
  }

  Future<void> getUserP() async {
      if (StorageDesign.validKey(StorageDesign.token) == false) {
      return;
    }
    try {

      final response = await _apiManager.read(ApiUrl.user, true);

      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);


        final user = UserResponse1.fromJson(decodedJson);

        userId.value = user.id;
        userName.value = user.name;
        userAvatar.value = user.profile.avatar;
        userAddress.value = user.profile.address;
        categoryId.value = user.categoryId;
      } else {

        CustomLoading.showNotification(
          message: "Falha ao buscar usuário",
          messageType: MessageType.error,
        );
      }
    } catch (e) {

      // CustomLoading.showNotification(
      //   message: e.toString(),
      //   messageType: MessageType.error,
      // );
    } finally {
    }
  }

  Future<void> getUserRating(int userId) async {
      if (StorageDesign.validKey(StorageDesign.token) == false) {
      return;
    }
    try {
      isLoading.value = true;

      final url = "v1/rating/$userId/user-rating";


      final response = await _apiManager.read(url, true);

      isLoading.value = false;

      if (response.statusCode == 200) {
        // 🔥 DECODE JSON (for readability)
        // final decoded = jsonDecode(response.body);

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
          message: "Falha ao buscar avaliações",
          messageType: MessageType.error,
        );
      }
    } catch (e) {
      isLoading.value = false;

      // CustomLoading.showNotification(
      //   message: e.toString(),
      //   messageType: MessageType.error,
      // );
    }
  }

  Future<void> updateProfile() async {
      if (StorageDesign.validKey(StorageDesign.token) == false) {
      return;
    }
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

      if (response.statusCode == 200) {
        emailController.clear();
        usernameController.clear();
        phoneController.clear();
        selectedRoleId.value = 0;
Get.back();
        CustomLoading.showNotification(
          message: "Perfil atualizado com sucesso",
          messageType: MessageType.success,
        );
      } else {
        final errorMessage = message["error"]?["message"] ?? "Falha na atualização";

        CustomLoading.showNotification(
          message: errorMessage,
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

  Future<void> updateIsAvailability(bool value) async {
      if (StorageDesign.validKey(StorageDesign.token) == false) {
      return;
    }
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
          message: message["error"]?["message"] ?? "Falha na atualização",
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

  Future<void> updateDaysOfAvailabilityFromUI(List<AvailabilityUI> days) async {
    if (!StorageDesign.validKey(StorageDesign.token)) return;

    final token = StorageDesign.readItem(StorageDesign.token);
    print("🔐 AUTH TOKEN: $token");

    try {
      isLoading.value = true;

      // Helper function to validate start < end
      bool isValidTime(String start, String end) {
        if (start.isEmpty || end.isEmpty) return true; // skip if day is closed
        final startParts = start.split(":").map(int.parse).toList();
        final endParts = end.split(":").map(int.parse).toList();

        final startMinutes = startParts[0] * 60 + startParts[1];
        final endMinutes = endParts[0] * 60 + endParts[1];

        return startMinutes < endMinutes;
      }

      // Build the array properly
      final List<Map<String, dynamic>> daysArray = [];
      for (var day in days) {
        final startTime = day.startTime.value == null ? "" : _formatTime(day.startTime.value!);
        final endTime = day.endTime.value == null ? "" : _formatTime(day.endTime.value!);

        // Validate start and end times
        if (!isValidTime(startTime, endTime)) {
          isLoading.value = false;
          CustomLoading.showNotification(
            message: "O horário de início deve ser antes do horário de término para ${day.apiDay}",
            messageType: MessageType.error,
          );
          return; // stop sending request if invalid
        }

        daysArray.add({
          "day": day.apiDay,
          "closed": day.isActive.value ? 0 : 1,
          "start_time": startTime,
          "end_time": endTime,
        });
      }

      final body = {"days": daysArray};

      final response = await _apiManager.post(
        ApiUrl.updateAvailability,
        body,
        true,
      );

      isLoading.value = false;

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        CustomLoading.showNotification(
          message: "Disponibilidade atualizada com sucesso",
          messageType: MessageType.success,
        );
        getAvailability(); // refresh
      } else {
        CustomLoading.showNotification(
          message: decoded["error"]?["message"] ?? "Falha na atualização",
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

class AvailabilityUI {
  final String uiDay;     // MONDAY
  final String apiDay;    // segunda
  RxBool isActive = false.obs;
  Rx<TimeOfDay?> startTime = Rx<TimeOfDay?>(null);
  Rx<TimeOfDay?> endTime = Rx<TimeOfDay?>(null);

  AvailabilityUI({
    required this.uiDay,
    required this.apiDay,
  });
}

String _formatTime(TimeOfDay time) {
  final h = time.hour.toString().padLeft(2, '0');
  final m = time.minute.toString().padLeft(2, '0');
  return '$h:$m';
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

class UserResponse1 {
  final int id;
  final String name;
  final String categoryId;
  final Profile profile;

  UserResponse1({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.profile,
  });

  factory UserResponse1.fromJson(Map<String, dynamic> json) {
    final user = json['user'];

    return UserResponse1(
      id: user['id'],
      name: user['name'], // ✅ THIS IS WHAT YOU WANT
      categoryId: user['category_id'].toString(),
      profile: Profile.fromJson(user['profile']),
    );
  }
}

class Profile {
  final String avatar;
  final String address;

  Profile({
    required this.avatar,
    required this.address,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      avatar: json['avatar'] ?? '',
      address: json['address'] ?? '',
    );
  }
}

