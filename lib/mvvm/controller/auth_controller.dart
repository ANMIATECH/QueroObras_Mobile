import '../const/export.dart';

class AuthController extends GetxController {
  final ApiManager _apiManager = ApiManager();
  final resetEmailController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final ValueNotifier<bool> rememberMeNotifier = ValueNotifier<bool>(false);
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController cnpjController = TextEditingController();
  final TextEditingController cepController = TextEditingController();

  final otpControllers = List.generate(5, (_) => TextEditingController());
  final focusNodes = List.generate(5, (_) => FocusNode());
  var isLoading = false.obs;

  void onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < 4) {
      focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }

  final RxInt remainingSeconds = 82.obs; // 1 minute 22 seconds
  final RxBool canResend = false.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    startCountdown();
    getServiceCategory(); // fetch categories when controller is initialized

  }

  void startCountdown() {
    canResend.value = false;
    remainingSeconds.value = 82; // reset timer to 1:22

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        timer.cancel();
        canResend.value = true;
      }
    });
  }


  Future<void> getServiceCategory() async {
    try {
      print("📡 Fetching service categories...");
      var response = await _apiManager.read(ApiUrl.serviceCategory, false);

      print("📩 Raw response body: ${response.body}");
      print("📌 Status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print("✅ JSON decoded: $data");

        var categories = data['categories'] as List<dynamic>? ?? [];
        print("📂 Categories fetched: $categories");

        // Safely map names and ignore nulls
        userRoleOptions.value =
            categories.map((cat) => (cat['name'] ?? '').toString())
                .where((name) => name.isNotEmpty)
                .toList();

        print("🔹 userRoleOptions updated: ${userRoleOptions.value}");
      } else {
        var message = jsonDecode(response.body);
        var error = message["error"]?["message"] ?? "Failed to fetch categories";
        print("❌ Error fetching categories: $error");

        SnackbarUtil.showSnackbar(
          title: "Fetch Failed",
          message: error,
          type: SnackbarType.error,
        );
      }
    } catch (e, stackTrace) {
      print("⚠️ Exception in getServiceCategory(): $e");
      print(stackTrace);
      SnackbarUtil.showSnackbar(
        title: "Error",
        message: e.toString(),
        type: SnackbarType.error,
      );
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
    for (var c in otpControllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    super.onClose();
  }


  String getOtp() {
    return otpControllers.map((e) => e.text).join();
  }


  RxBool isButtonLoading = false.obs;
  RxString selectedUserStatus = 'Cliente'.obs;
  RxString selectedRoleStatus = ''.obs;
  RxString selectedDocumentType = ''.obs; // 'CPF' or 'CNPJ'

  final List<String> userStatusOptions = [
    'Cliente',
    'Prestador de serviço',
  ];

  var userRoleOptions = <String>[].obs; // store category names

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void handleSubmit() {
    if (formKey.currentState?.validate() ?? false) {
      // Handle password reset logic here
      print('Reset password for: ${emailController.text}');
    }
  }
}
