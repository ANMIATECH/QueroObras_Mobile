import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../const/export.dart';
import '../screens/auth/signuoOtp_verification.dart';

class LoginController extends GetxController {
  var isSignupFormValid = false.obs;
  final RxBool agree = false.obs;


  final ApiManager _apiManager = ApiManager();
  final emailController = TextEditingController();
  final resetEmailController = TextEditingController();
  final companyTypeController = TextEditingController();
  final companyNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final fullNameController = TextEditingController();
  final legalRepNameController = TextEditingController(); // CNPJ
  final tradeNameController = TextEditingController(); // CNPJ
  final motherNameController = TextEditingController();
  final birthDateController = TextEditingController();
  final addressController = TextEditingController();
  final businessEmailController = TextEditingController();
  final cepController = TextEditingController();
  final stateRegistrationController = TextEditingController(); // CNPJ
  final phoneNumberController = TextEditingController();
  final cpfController = TextEditingController();
  final cnpjController = TextEditingController();
  final serviceController = TextEditingController();
  final ValueNotifier<bool> rememberMeNotifier = ValueNotifier<bool>(false);
  final otpControllers = List.generate(6, (_) => TextEditingController());
  final focusNodes = List.generate(6, (_) => FocusNode());

  var isLoading = false.obs;

  XFile? cnpjDoc;
  XFile? driverLicense;
  XFile? avatar;

  Future pickCnpjDoc() async {
    final picker = ImagePicker();
    cnpjDoc = await picker.pickImage(source: ImageSource.gallery);
    update();
  }

  Future pickDriverLicense() async {
    final picker = ImagePicker();
    driverLicense = await picker.pickImage(source: ImageSource.gallery);
    update();
  }

  Future pickAvatar() async {
    final picker = ImagePicker();
    avatar = await picker.pickImage(source: ImageSource.gallery);
    update();
  }


  void onOtpChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < otpControllers.length - 1) {
        focusNodes[index + 1].requestFocus();
      } else {
        // Last input → close keyboard automatically
        focusNodes[index].unfocus();
      }
    } else {
      if (index > 0) {
        focusNodes[index - 1].requestFocus();
      }
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
    fullNameController.dispose();
    emailController.dispose();
    businessEmailController.dispose();
    resetEmailController.dispose();
    companyTypeController.dispose();
    companyNameController.dispose();
    legalRepNameController.dispose();
    tradeNameController.dispose();
    motherNameController.dispose();
    birthDateController.dispose();
    addressController.dispose();
    cepController.dispose();
    stateRegistrationController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    cpfController.dispose();
    cnpjController.dispose();
    serviceController.dispose();
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

  RxString selectedDocumentType = RxString('CPF');
  RxString selectedUserStatus = RxString('CPF');

  final List<String> userStatusOptions = ['CPF', 'CNPJ'];

  void setUserStatus(String newStatus) {
    selectedUserStatus.value = newStatus;

    if (newStatus == "CPF") {
      selectedDocumentType.value = "CPF";
      cnpjController.clear(); // clear CNPJ if switching to CPF
    } else if (newStatus == "CNPJ") {
      selectedDocumentType.value = "CNPJ";
      cpfController.clear(); // clear CPF if switching to CNPJ
    }
  }


  var userRoleList = <CategoryModel>[].obs;
  var selectedRoleStatus = 0.obs; // RxInt

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void handleSubmit() {
    if (formKey.currentState?.validate() ?? false) {
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



  void _validateSignupForm() {
    // Base required fields
    bool baseFieldsValid =
        fullNameController.text.isNotEmpty &&
            emailController.text.isNotEmpty &&
            passwordController.text.isNotEmpty &&
            confirmPasswordController.text.isNotEmpty &&
            phoneNumberController.text.isNotEmpty;

    // Service provider fields
    bool serviceFieldsValid = true;

    if (selectedUserStatus.value == "Prestador de serviço") {
      if (selectedDocumentType.value == "CPF") {
        serviceFieldsValid = cpfController.text.isNotEmpty;
      } else if (selectedDocumentType.value == "CNPJ") {
        serviceFieldsValid = cnpjController.text.isNotEmpty &&
            companyNameController.text.isNotEmpty &&
            legalRepNameController.text.isNotEmpty &&
            tradeNameController.text.isNotEmpty &&
            motherNameController.text.isNotEmpty &&
            birthDateController.text.isNotEmpty &&
            cepController.text.isNotEmpty &&
            addressController.text.isNotEmpty;
      }

      // Category (role) is required for service provider
      serviceFieldsValid = serviceFieldsValid && selectedRoleStatus.value != 0;
    }

    isSignupFormValid.value = baseFieldsValid && serviceFieldsValid;
  }

  void setupSignupValidation() {
    // Base fields
    fullNameController.addListener(_validateSignupForm);
    emailController.addListener(_validateSignupForm);
    passwordController.addListener(_validateSignupForm);
    confirmPasswordController.addListener(_validateSignupForm);
    phoneNumberController.addListener(_validateSignupForm);

    // Conditional fields
    cpfController.addListener(_validateSignupForm);
    cnpjController.addListener(_validateSignupForm);
    companyNameController.addListener(_validateSignupForm);
    legalRepNameController.addListener(_validateSignupForm);
    tradeNameController.addListener(_validateSignupForm);
    motherNameController.addListener(_validateSignupForm);
    birthDateController.addListener(_validateSignupForm);
    cepController.addListener(_validateSignupForm);
    addressController.addListener(_validateSignupForm);

    // Observables
    selectedUserStatus.listen((_) => _validateSignupForm());
    selectedRoleStatus.listen((_) => _validateSignupForm());
    selectedDocumentType.listen((_) => _validateSignupForm());
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
      print("📤 OTP VERIFY REQUEST BODY: $body");
      print("📩 RAW RESPONSE BODY: ${response.body}");
      print("📩 STATUS CODE: ${response.statusCode}");
      print("📩 HEADERS: ${response.headers}");

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

        var token = message["token"];
        if (token != null) {
          StorageDesign.createItem(StorageDesign.token, token);
        }

        String? userStatus = message["user"]?["user_status"]?.toString().toLowerCase();
        if (userStatus != null) {
          StorageDesign.createItem("user_status", userStatus);
        }
        print("🟦 USER STATUS FROM SERVER: $userStatus");

        if (userStatus == "cpf") {
          print("➡ Navigating to CPF Dashboard");
          Get.offAllNamed(RouteNameV1.cpfProfile, arguments: email);

        } else if (userStatus == "cnpj") {
          print("➡ Navigating to CNPJ Dashboard");
          Get.offAllNamed(RouteNameV1.cnpjProfile, arguments: email);
        }
      }

    } catch (e) {
      isLoading.value = false;


      SnackbarUtil.showSnackbar(
        title: "Verification Failed",
        message: "$e",
        type: SnackbarType.error,
      );
    }
  }

  Future signUp() async {
    _validateSignupForm();

    if (!isSignupFormValid.value) {
      SnackbarUtil.showSnackbar(
        title: "Falha no Cadastro",
        message: "Por favor, preencha todos os campos obrigatórios corretamente.",
        type: SnackbarType.error,
      );
      return;
    }

    try {
      final fullName = fullNameController.text.trim();
      final password = passwordController.text.trim();
      final confirmPassword = confirmPasswordController.text.trim();
      final phoneNumber = phoneNumberController.text.trim();

      var body = <String, dynamic>{
        "name": fullName,
        "phone_number": phoneNumber,
        "password": password,
        "password_confirmation": confirmPassword,
        "user_status": selectedDocumentType.value, // CPF ou CNPJ
      };

      if (selectedDocumentType.value == "CPF") {
        if (cpfController.text.trim().isNotEmpty) {
          body["cpf"] = cpfController.text.trim();
        }
        // Add other CPF-specific fields
        body.addAll({
          "trade_name": tradeNameController.text.trim(),
          "mother_name": motherNameController.text.trim(),
          "email": emailController.text.trim(),
          "address": addressController.text.trim(),
          "birth_date": birthDateController.text.trim(),
          "zip_code": cepController.text.trim(),
        });
      } else if (selectedDocumentType.value == "CNPJ") {
        if (cnpjController.text.trim().isNotEmpty) {
          body["cnpj"] = cnpjController.text.trim();
        }
        // Add other CNPJ-specific fields
        body.addAll({
          "corporate_name": companyNameController.text.trim(),
          "legal_representative_name": legalRepNameController.text.trim(),
          "trade_name": tradeNameController.text.trim(),
          "mother_name": motherNameController.text.trim(),
          "email": emailController.text.trim(),
          "address": addressController.text.trim(),
          "birth_date": birthDateController.text.trim(),
          "zip_code": cepController.text.trim(),
          "state_registration": stateRegistrationController.text.trim(),
        });
      }

      body.removeWhere((key, value) => value == null || value.toString().isEmpty);


      if (selectedRoleStatus.value != 0) {
        body["category_id"] = selectedRoleStatus.value;
      }
      print("📦 Body to send: $body");


      isLoading.value = true;
      var response = await _apiManager.post(ApiUrl.signup, body, false);
      isLoading.value = false;

      print("📩 Raw response body: ${response.body}");
      print("📌 Status code: ${response.statusCode}");

      final message = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        passwordController.clear();
        confirmPasswordController.clear();
        fullNameController.clear();

        SnackbarUtil.showSnackbar(
          title: "Conta criada com sucesso",
          message: "Por favor, verifique seu e-mail usando o OTP enviado.",
          type: SnackbarType.success,
        );

        Get.to(() => SignUpOtpVerification(email: body["email"]));
      } else {
        String errorMessage = "Falha no cadastro";
        if (message["error"]?["details"] != null) {
          final details = message["error"]["details"] as Map<String, dynamic>;
          if (details.isNotEmpty) {
            errorMessage = details.values.first[0].toString();
          }
        } else if (message["error"]?["message"] != null) {
          errorMessage = message["error"]["message"].toString();
        }

        SnackbarUtil.showSnackbar(
          title: "Falha no Cadastro",
          message: errorMessage,
          type: SnackbarType.error,
        );
      }
    } catch (e) {
      isLoading.value = false;
      SnackbarUtil.showSnackbar(
        title: "Falha no Cadastro",
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

  Future uploadProfilePicNDoc() async {
    try {
      if (cnpjDoc == null || driverLicense == null || avatar == null) {
        SnackbarUtil.showSnackbar(
          title: "Upload Failed",
          message: "All documents are required",
          type: SnackbarType.error,
        );
        return;
      }

      isLoading.value = true;

      var request = http.MultipartRequest("POST", Uri.parse(ApiUrl.picNDoc));

      // Attach files
      request.files.add(
        await http.MultipartFile.fromPath("cnpj_document", cnpjDoc!.path),
      );

      request.files.add(
        await http.MultipartFile.fromPath("identifican_driver_license", driverLicense!.path),
      );

      request.files.add(
        await http.MultipartFile.fromPath("avatar", avatar!.path),
      );

      // Add token if needed
      String? token = await StorageDesign.readItem(StorageDesign.token);
      if (token != null) {
        request.headers['Authorization'] = "Bearer $token";
      }

      // Send
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      isLoading.value = false;

      print("RAW RESPONSE STATUS: ${response.statusCode}");
      print("RAW RESPONSE BODY: ${response.body}");

      dynamic message;
      try {
        message = jsonDecode(response.body);
      } catch (e) {
        SnackbarUtil.showSnackbar(
          title: "Upload Failed",
          message: "Invalid JSON response",
          type: SnackbarType.error,
        );
        return;
      }

      // SUCCESS
      if (response.statusCode == 200 || response.statusCode == 201) {
        SnackbarUtil.showSnackbar(
          title: "Success",
          message: "Documents uploaded successfully",
          type: SnackbarType.success,
        );

        Get.offAllNamed(RouteNameV1.bottomNav);
      }
      // FAILED
      else {
        String errorMsg = "Upload failed";

        if (message is Map &&
            message.containsKey("error") &&
            message["error"].containsKey("message")) {
          errorMsg = message["error"]["message"];
        }

        SnackbarUtil.showSnackbar(
          title: "Upload Failed",
          message: errorMsg,
          type: SnackbarType.error,
        );
      }
    } catch (e) {
      isLoading.value = false;
      print("UPLOAD ERROR: $e");

      SnackbarUtil.showSnackbar(
        title: "Upload Failed",
        message: "$e",
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
