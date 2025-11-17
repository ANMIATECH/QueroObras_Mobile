import '../const/export.dart';
import '../screens/auth/signuoOtp_verification.dart';

class LoginController extends GetxController {
  final ApiManager _apiManager = ApiManager();
  final emailController = TextEditingController();
  final resetEmailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final ValueNotifier<bool> rememberMeNotifier = ValueNotifier<bool>(false);
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController userStatusController = TextEditingController();
  final TextEditingController cnpjController = TextEditingController();
  final TextEditingController cepController = TextEditingController();
  final TextEditingController serviceController = TextEditingController();
  final otpControllers = List.generate(6, (_) => TextEditingController());
  final focusNodes = List.generate(6, (_) => FocusNode());

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
    getServiceCategory();

    emailController.addListener(_validateForm);
    resetEmailController.addListener(_validateEmailForm);
    passwordController.addListener(_validateForm);

    passwordController.addListener(_validatePassword);
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




  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    resetEmailController.dispose();
    super.onClose();
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

  RxString selectedDocumentType = ''.obs; // 'CPF' or 'CNPJ'

  final List<String> userStatusOptions = [
    'Cliente',
    'Prestador de serviço',
  ];

  RxString selectedUserStatus = 'Cliente'.obs;

  void setUserStatus(String value) {
    selectedUserStatus.value = value;
  }


  var userRoleList = <CategoryModel>[].obs;
  var selectedRoleStatus = 0.obs; // RxInt

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void handleSubmit() {
    if (formKey.currentState?.validate() ?? false) {
      // Handle password reset logic here
      print('Reset password for: ${emailController.text}');
    }}



  final forgetPasswordOtpController = TextEditingController();
  var isFormValid = false.obs;
  var isEmailFormValid = false.obs;
  var hasMinLength = false.obs;
  var hasUpperLowerNumber = false.obs;

  var isLoggedIn = false.obs;

  bool get loggedIn => isLoggedIn.value;


  void _validatePassword() {
    final value = passwordController.text;
    hasMinLength.value = value.length >= 8;
    hasUpperLowerNumber.value = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)',
    ).hasMatch(value);
    _validateForm();
  }

  void _validateForm() {
    update();
    isFormValid.value =
        emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
  }

  void _validateEmailForm() {
    update();
    isEmailFormValid.value =
        resetEmailController.text.isNotEmpty;
  }


// Add at the top of your controller
  var isSignupFormValid = false.obs;

// Updated _validateSignupForm
  void _validateSignupForm() {
    isSignupFormValid.value =
        fullNameController.text.isNotEmpty &&
            emailController.text.isNotEmpty &&
            passwordController.text.isNotEmpty &&
            confirmPasswordController.text.isNotEmpty;
  }
// Call this whenever relevant field changes
  void setupSignupValidation() {
    emailController.addListener(_validateSignupForm);
    fullNameController.addListener(_validateSignupForm);
    passwordController.addListener(_validateSignupForm);
    confirmPasswordController.addListener(_validateSignupForm);
    cpfController.addListener(_validateSignupForm);
    cnpjController.addListener(_validateSignupForm);
    selectedUserStatus.listen((_) => _validateSignupForm());
    selectedRoleStatus.listen((_) => _validateSignupForm());
  }


  Future login() async {
    try {
      var body = {
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      };

      isLoading.value = true;
      var response = await _apiManager.post(ApiUrl.login, body, false);
      isLoading.value = false;

      print("RAW RESPONSE STATUS: ${response.statusCode}");
      print("RAW RESPONSE BODY: ${response.body}");

      dynamic message;
      try {
        message = jsonDecode(response.body);
      } catch (e) {
        print("JSON DECODE FAILED: $e");
        SnackbarUtil.showSnackbar(
          title: "Login Failed",
          message: "Server returned invalid JSON",
          type: SnackbarType.error,
        );
        return;
      }

      if (response.statusCode == 200) {
        // Login successful
        passwordController.clear();
        emailController.clear();

        SnackbarUtil.showSnackbar(
          title: "Login Successful",
          message: "User logged in successfully",
          type: SnackbarType.success,
        );

        Get.offAllNamed(RouteNameV1.bottomNav);

        var token = message["data"]["token"];
        var userType = message["data"]["user"]["onboard_type"].toString();

        if (rememberMeNotifier.value) {
          StorageDesign.createItem(StorageDesign.token, token);
          StorageDesign.createItem(StorageDesign.userType, userType);
        } else {
          StorageDesign.deleteItem(StorageDesign.token);
          StorageDesign.deleteItem(StorageDesign.userType);
        }

      } else {
        // Extract the error message from JSON
        String errorMsg = "Login failed"; // default
        if (message.containsKey("error") && message["error"].containsKey("message")) {
          errorMsg = message["error"]["message"];
        }

        SnackbarUtil.showSnackbar(
          title: "Login Failed",
          message: errorMsg,
          type: SnackbarType.error,
        );

        // Optional: handle next_step or action if provided (e.g., email verification)
        if (message.containsKey("action") && message["action"] == "verify_email") {
          print("Next Step: ${message["next_step"]}");
          // You can navigate to OTP screen here if needed
        }
      }
    } catch (e) {
      isLoading.value = false;
      print("LOGIN ERROR: $e");
      SnackbarUtil.showSnackbar(
        title: "Login Failed",
        message: "$e",
        type: SnackbarType.error,
      );
    }
  }

  Future forgetPassword() async {
    try {
      final userEmail = resetEmailController.text.trim();

      if (userEmail.isEmpty) {
        SnackbarUtil.showSnackbar(
          title: "Invalid Email",
          message: "Please enter your email before proceeding.",
          type: SnackbarType.error,
        );
        return;
      }

      var body = {"email": userEmail};
      isLoading.value = true;

      var response = await _apiManager.post(ApiUrl.resetPasswordEmail, body, false);
      isLoading.value = false;

      print("📩 Raw response: ${response.body}");
      print("📨 Sending email: $userEmail");

      if (response.statusCode == 200) {
        try {
          final decoded = jsonDecode(response.body);
          SnackbarUtil.showSnackbar(
            title: "Password Reset Link Sent",
            message: "A password reset OTP has been sent to $userEmail",
            type: SnackbarType.success,
          );

          // Navigate to OTP screen, passing the email string
          Get.toNamed(RouteNameV1.otpPin, arguments: userEmail);

          // Optionally clear controller after navigation
          resetEmailController.clear();
        } catch (jsonError) {
          print("⚠️ JSON Decode Failed: $jsonError");
          print("Response was not JSON: ${response.body}");
        }
      } else {
        print("❌ Response code: ${response.statusCode}");
        print("Response body: ${response.body}");
        SnackbarUtil.showSnackbar(
          title: "Link Sending Failed",
          message: "Server returned an invalid response (${response.statusCode})",
          type: SnackbarType.error,
        );
      }
    } catch (e, stackTrace) {
      isLoading.value = false;
      SnackbarUtil.showSnackbar(
        title: "Link Sending Failed",
        message: "$e",
        type: SnackbarType.error,
      );
      print("⚠️ Exception during forgetPassword(): $e");
      print(stackTrace);
    }
  }

  Future resendCode({String? email}) async {
    try {
      final userEmail = email?.trim() ?? resetEmailController.text.trim();

      if (userEmail.isEmpty) {
        SnackbarUtil.showSnackbar(
          title: "Invalid Email",
          message: "Please enter your email before proceeding.",
          type: SnackbarType.error,
        );
        return;
      }

      var body = {
        "email": userEmail,
      };

      isLoading.value = true;
      var response = await _apiManager.post(ApiUrl.resetPasswordEmail, body, false);
      isLoading.value = false;

      print("📩 Raw response: ${response.body}");
      print("Email sent to API: $userEmail");


      var decoded;
      try {
        decoded = jsonDecode(response.body);
      } catch (_) {
        decoded = null;
      }

      if (response.statusCode == 200) {
        startCountdown();
        // Don't clear during resend
        if (email == null) resetEmailController.clear();

        SnackbarUtil.showSnackbar(
          title: "OTP Sent",
          message: "A password reset OTP has been sent to $userEmail",
          type: SnackbarType.success,
        );

        Get.toNamed(RouteNameV1.otpPin, arguments: userEmail);
      }
      else {
        // Handle backend validation errors
        String errorMessage = "Failed to send OTP.";

        if (decoded != null) {
          if (decoded["errors"] != null &&
              decoded["errors"]["email"] != null &&
              decoded["errors"]["email"].isNotEmpty) {
            errorMessage = decoded["errors"]["email"][0];
          }
          else if (decoded["message"] != null) {
            errorMessage = decoded["message"];
          }
        }

        SnackbarUtil.showSnackbar(
          title: "Failed",
          message: errorMessage,
          type: SnackbarType.error,
        );
      }
    } catch (e) {
      isLoading.value = false;
      SnackbarUtil.showSnackbar(
        title: "Failed",
        message: "$e",
        type: SnackbarType.error,
      );
      print("⚠️ sendOtp Exception: $e");
    }
  }

  Future verifyForgetPasswordOtp(String otp, {required String email}) async {
    if (otp.trim().isEmpty) {
      SnackbarUtil.showSnackbar(
        title: "Invalid OTP",
        message: "Please enter the OTP before proceeding.",
        type: SnackbarType.error,
      );
      return;
    }

    var body = {
      "email": email.trim(),
      "otp": otp.trim(),
    };

    try {
      isLoading.value = true;
      var response = await _apiManager.post(ApiUrl.verifyOtp, body, false);
      isLoading.value = false;

      // 🔍 PRINT EVERYTHING
      print("-----------------------------------------------------------");
      print("📤 OTP VERIFY REQUEST BODY: $body");
      print("📩 RAW RESPONSE BODY: ${response.body}");
      print("📩 STATUS CODE: ${response.statusCode}");
      print("📩 HEADERS: ${response.headers}");
      print("-----------------------------------------------------------");

      var message;
      try {
        message = jsonDecode(response.body);
        print("📩 DECODED JSON: $message");
      } catch (e) {
        print("❌ JSON PARSE ERROR: $e");
        message = {"error": {"message": "Invalid server response"}};
      }

      if (response.statusCode == 200) {
        SnackbarUtil.showSnackbar(
          title: "OTP Verified",
          message: "OTP verification successful for $email",
          type: SnackbarType.success,
        );

        Get.toNamed(RouteNameV1.resetPasswordPin, arguments: email);

        var token = message["data"]["token"];
        StorageDesign.createItem(StorageDesign.token, token);

      } else {
        // Default message
        String errorMessage = "OTP verification failed";

        if (message["error"] != null) {
          if (message["error"]["details"] != null) {
            final details = message["error"]["details"] as Map<String, dynamic>;
            if (details.isNotEmpty) {
              errorMessage = details.values.first[0].toString();
            }
          } else if (message["error"]["message"] != null) {
            errorMessage = message["error"]["message"].toString();
          }
        }

        print("❌ FINAL ERROR MESSAGE: $errorMessage");

        SnackbarUtil.showSnackbar(
          title: "Verification Failed",
          message: errorMessage,
          type: SnackbarType.error,
        );
      }
    } catch (e) {
      isLoading.value = false;

      print("⚠️ verifyForgetPasswordOtp Exception: $e");

      SnackbarUtil.showSnackbar(
        title: "Verification Failed",
        message: "$e",
        type: SnackbarType.error,
      );
    }
  }

  Future verifyPasswordOtp(String otp, {required String email}) async {
    if (otp.trim().isEmpty) {
      SnackbarUtil.showSnackbar(
        title: "Invalid OTP",
        message: "Please enter the OTP before proceeding.",
        type: SnackbarType.error,
      );
      return;
    }

    var body = {
      "email": email.trim(),
      "otp": otp.trim(),
    };

    try {
      isLoading.value = true;
      var response = await _apiManager.post(ApiUrl.verifyOtp, body, false);
      isLoading.value = false;

      // 🔍 PRINT EVERYTHING
      print("-----------------------------------------------------------");
      print("📤 OTP VERIFY REQUEST BODY: $body");
      print("📩 RAW RESPONSE BODY: ${response.body}");
      print("📩 STATUS CODE: ${response.statusCode}");
      print("📩 HEADERS: ${response.headers}");
      print("-----------------------------------------------------------");

      var message;
      try {
        message = jsonDecode(response.body);
        print("📩 DECODED JSON: $message");
      } catch (e) {
        print("❌ JSON PARSE ERROR: $e");
        message = {"error": {"message": "Invalid server response"}};
      }

      if (response.statusCode == 200) {
        SnackbarUtil.showSnackbar(
          title: "OTP Verified",
          message: "OTP verification successful for $email",
          type: SnackbarType.success,
        );

        Get.offAllNamed(RouteNameV1.bottomNav, arguments: email);

        var token = message["token"];
        StorageDesign.createItem(StorageDesign.token, token);

      } else {
        // Default message
        String errorMessage = "OTP verification failed";

        if (message["error"] != null) {
          if (message["error"]["details"] != null) {
            final details = message["error"]["details"] as Map<String, dynamic>;
            if (details.isNotEmpty) {
              errorMessage = details.values.first[0].toString();
            }
          } else if (message["error"]["message"] != null) {
            errorMessage = message["error"]["message"].toString();
          }
        }

        print("❌ FINAL ERROR MESSAGE: $errorMessage");

        SnackbarUtil.showSnackbar(
          title: "Verification Failed",
          message: errorMessage,
          type: SnackbarType.error,
        );
      }
    } catch (e) {
      isLoading.value = false;

      print("⚠️ verifyForgetPasswordOtp Exception: $e");

      SnackbarUtil.showSnackbar(
        title: "Verification Failed",
        message: "$e",
        type: SnackbarType.error,
      );
    }
  }


  Future<void> signUp() async {
    _validateSignupForm(); // validate form before submitting

    if (!isSignupFormValid.value) {
      SnackbarUtil.showSnackbar(
        title: "Signup Failed",
        message: "Please fill all required fields correctly.",
        type: SnackbarType.error,
      );
      return;
    }

    try {
      final email = emailController.text.trim();
      final fullName = fullNameController.text.trim();
      final password = passwordController.text.trim();
      final confirmPassword = confirmPasswordController.text.trim();
      final phoneNumber = phoneNumberController.text.trim();

      // Base payload
      var body = <String, dynamic>{
        "name": fullName,
        "email": email,
        "phone_number": phoneNumber,
        "password": password,
        "password_confirmation": confirmPassword,
        "user_status": selectedUserStatus.value,
      };

      // Only add service provider fields if applicable
      if (selectedUserStatus.value == "Prestador de serviço") {
        if (selectedDocumentType.value == "CPF") {
          body["cpf"] = cpfController.text.trim();
        } else if (selectedDocumentType.value == "CNPJ") {
          body["cnpj"] = cnpjController.text.trim();
        }

        body["zip_code"] = cepController.text.trim();
        body["category_id"] = selectedRoleStatus.value; // int is allowed now
      }

      body.removeWhere((key, value) => value == null || value.toString().isEmpty);

      isLoading.value = true;
      var response = await _apiManager.post(ApiUrl.signup, body, false);
      isLoading.value = false;

      var message = jsonDecode(response.body);
      print("📩 Raw response body: ${response.body}");
      print("📌 Status code: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        passwordController.clear();
        confirmPasswordController.clear();

        SnackbarUtil.showSnackbar(
          title: "Account Created Successfully",
          message: "Please verify your email using the OTP sent to you.",
          type: SnackbarType.success,
        );

        Get.to(() => SignUpOtpVerification(email: email));

      } else {
        // Extract detailed error message if available
        String errorMessage = "Signup failed";
        if (message["error"]?["details"] != null) {
          final details = message["error"]["details"] as Map<String, dynamic>;
          if (details.isNotEmpty) {
            // Get first error message
            errorMessage = details.values.first[0].toString();
          }
        } else if (message["error"]?["message"] != null) {
          errorMessage = message["error"]["message"].toString();
        }

        SnackbarUtil.showSnackbar(
          title: "Signup Failed",
          message: errorMessage,
          type: SnackbarType.error,
        );
      }
    } catch (e) {
      isLoading.value = false;
      SnackbarUtil.showSnackbar(
        title: "Signup Failed",
        message: "$e",
        type: SnackbarType.error,
      );
    }
  }

  Future<void> getServiceCategory() async {
    try {
      print("📡 Fetching service categories...");
      var response = await _apiManager.read(ApiUrl.serviceCategory, false);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var categories = data['categories'] as List<dynamic>? ?? [];

        userRoleList.value =
            categories.map((c) => CategoryModel.fromJson(c)).toList();

        print("✅ userRoleList updated: $userRoleList");
      } else {
        var message = jsonDecode(response.body);
        var error = message["error"]?["message"] ?? "Failed to fetch categories";
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


class CategoryModel {
  final int id;
  final String name;

  CategoryModel({required this.id, required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
