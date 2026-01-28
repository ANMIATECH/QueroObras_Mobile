import 'package:http/http.dart' as http;

import '../const/export.dart';
import '../screens/auth/signup_otp_verification.dart';

class LoginController extends GetxController {
  var isSignupFormValid = false.obs;
  final RxBool agree = false.obs;

  final ApiManager _apiManager = ApiManager();
  final emailController = TextEditingController();
  final setPassword = TextEditingController();
  final resetEmailController = TextEditingController();
  final companyTypeController = TextEditingController();
  final companyNameController = TextEditingController();
  final passwordController = TextEditingController();
  final setComfirmPassword = TextEditingController();
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

  // For storing the IDs corresponding to the selected names
  RxList<int> selectedRoleStatusIds = <int>[].obs;
  RxList<String> selectedRolesNames = <String>[].obs;



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

  void toggleRememberMe() {
    rememberMeNotifier.value = !rememberMeNotifier.value;
  }

  final RxInt remainingSeconds = 82.obs; // 1 minute 22 seconds
  final RxBool canResend = false.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    startCountdown();
    // getServiceCategory();

    emailController.addListener(_validateForm);
    resetEmailController.addListener(_validateEmailForm);
    passwordController.addListener(_validateForm);

    passwordController.addListener(_validatePassword);
  }
void startCountdown() {
    // 1. Cancel any existing timer first to prevent duplicates
    _timer?.cancel();
    
    canResend.value = false;
    remainingSeconds.value = 82; 

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // 2. Check if the controller is still active before updating
      if (isClosed) {
        timer.cancel();
        return;
      }

      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        canResend.value = true;
        timer.cancel();
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
    _timer?.cancel();
    _timer = null;
   
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
    if (formKey.currentState?.validate() ?? false) {}
  }

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
    isEmailFormValid.value = resetEmailController.text.isNotEmpty;
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
        serviceFieldsValid =
            cnpjController.text.isNotEmpty &&
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

      dynamic message = jsonDecode(response.body);

      if (response.statusCode == 200) {


        // Extract login info
        var token = message["token"];
        var userStatus = message["user"]["user_status"];



        // REMEMBER ME LOGIC
        if (rememberMeNotifier.value) {
          // 🔥 Save permanently
          StorageDesign.createItem(StorageDesign.token, token);
          StorageDesign.createItem(StorageDesign.userType, userStatus);
          StorageDesign.deleteItem(StorageDesign.tokenExpiry);
        } else {
          // 🔥 Save token but WITH 24-hour expiry
          StorageDesign.createItem(StorageDesign.token, token);
          StorageDesign.createItem(StorageDesign.userType, userStatus);

          // Save expiry timestamp (24 hours from now)
          DateTime expiry = DateTime.now().add(Duration(hours: 24));
          StorageDesign.createItem(StorageDesign.tokenExpiry, expiry.toIso8601String());
        }

        // ✅ SUCCESS MESSAGE
        CustomLoading.showNotification(
          message: "Login realizado com sucesso",
          messageType: MessageType.success,
        );


        // Navigation
        if (token != null && token.toString().isNotEmpty) {
          if (userStatus == "cpf") {
            Get.offAllNamed(AppRoutes.cpfBottomNav);
          } else if (userStatus == "cnpj") {
            Get.offAllNamed(AppRoutes.cpnjBottomNav);
          }
        }

      } else {
        String errorMsg = "Falha no login";

        if (message.containsKey("error") &&
            message["error"].containsKey("message")) {
          errorMsg = message["error"]["message"];
        }

        CustomLoading.showNotification(
          message: errorMsg,
          messageType: MessageType.error,
        );
      }
    } catch (e) {
      isLoading.value = false;
      CustomLoading.showNotification(
        message: "$e",
        messageType: MessageType.error,
      );
    }
  }

  var isResetPasswordLoading = false.obs;

  Future resetPassword({
    required String otp,
    required String email,
    dynamic context,
  }) async {
    try {
      if (setComfirmPassword.text.trim() != setPassword.text.trim()) {
        CustomLoading.showNotification(
          message: "Senha e Confirmação de Senha não coincidem",
          messageType: MessageType.error,
        );
        return;
      }
      var body = {
        "email": email.trim(),
        "password": setComfirmPassword.text.trim(),
        "password_confirmation": setComfirmPassword.text.trim(),
        "otp": otp.trim(),
      };

      isResetPasswordLoading.value = true;
      var response = await _apiManager.post(
        ApiUrl.resetPasswordEmail,
        body,
        false,
      );
      isResetPasswordLoading.value = false;

      dynamic message = jsonDecode(response.body);

      if (response.statusCode == 200) {
        CustomLoading.showNotification(
          message: "Senha alterada com sucesso",
          messageType: MessageType.success,
        );
        Navigator.of(context).pushReplacementNamed(AppRoutes.login);
      } else {
        // Extract the error message from JSON
        String errorMsg = "Falha no login";

        if (message.containsKey("error") &&
            message["error"].containsKey("message")) {
          errorMsg = message["error"]["message"];
        }

        CustomLoading.showNotification(
          message: errorMsg,
          messageType: MessageType.error,
        );

        // Optional: handle next_step or action if provided (e.g., email verification)
        if (message.containsKey("action") &&
            message["action"] == "verify_email") {
          // You can navigate to OTP screen here if needed
        }
      }
    } catch (e) {
      isResetPasswordLoading.value = false;
      CustomLoading.showNotification(
        message: "$e",
        messageType: MessageType.error,
      );
    }
  }

  Future forgetPassword(dynamic context) async {
    try {
      final userEmail = resetEmailController.text.trim();

      if (userEmail.isEmpty) {
        CustomLoading.showNotification(
          message: "Por favor, insira seu e-mail antes de continuar.",
          messageType: MessageType.error,
        );
        return;
      }

      var body = {"email": userEmail};
      isLoading.value = true;

      var response = await _apiManager.post(
        ApiUrl.resetPasswordEmail,
        body,
        false,
      );
      isLoading.value = false;
      jsonDecode(response.body);
      isLoading.value = false;
      print(response.body);

      if (response.statusCode == 200) {
        CustomLoading.showNotification(
          message: "Um código OTP para redefinição de senha foi enviado para $userEmail",
          messageType: MessageType.success,
        );
        Navigator.of(
          context,
        ).pushNamed(AppRoutes.otpPin, arguments: {"email": userEmail});

        resetEmailController.clear();
      } else {
        CustomLoading.showNotification(
          message:
          "Servidor retornou uma resposta inválida (${response.statusCode})",
          messageType: MessageType.error,
        );
        print(response.body);

      }
    } catch (e) {
      isLoading.value = false;
      CustomLoading.showNotification(
        message: "$e",
        messageType: MessageType.error,
      );
    }
  }

  Future resendCode({String? email}) async {
    try {
      final userEmail = email?.trim() ?? resetEmailController.text.trim();

      if (userEmail.isEmpty) {
        CustomLoading.showNotification(
          message: "Por favor, insira seu e-mail antes de continuar.",
          messageType: MessageType.error,
        );
        return;
      }

      var body = {"email": userEmail};

      isLoading.value = true;
      var response = await _apiManager.post(
        ApiUrl.resetPasswordEmail,
        body,
        false,
      );
      isLoading.value = false;

      var decoded = jsonDecode(response.body);
      isLoading.value = false;

      if (response.statusCode == 200) {
        startCountdown();
        // Don't clear during resend
        if (email == null) resetEmailController.clear();

        CustomLoading.showNotification(
          message: "Um código OTP para redefinição de senha foi enviado para $userEmail",
          messageType: MessageType.success,
        );

        // Get.toNamed(RouteNameV1.otpPin, arguments: userEmail);
      } else {
        // Handle backend validation errors
        String errorMessage = "Falha ao enviar o OTP.";

        if (decoded != null) {
          if (decoded["errors"] != null &&
              decoded["errors"]["email"] != null &&
              decoded["errors"]["email"].isNotEmpty) {
            errorMessage = decoded["errors"]["email"][0];
          } else if (decoded["message"] != null) {
            errorMessage = decoded["message"];
          }
        }

        CustomLoading.showNotification(
          message: errorMessage,
          messageType: MessageType.error,
        );
      }
    } catch (e) {
      isLoading.value = false;
      CustomLoading.showNotification(
        message: "$e",
        messageType: MessageType.error,
      );
    }
  }

  Future verifyForgetPasswordOtp(
    String otp,
    context, {
    required String email,
  }) async {
    if (otp.trim().isEmpty) {
      CustomLoading.showNotification(
        message: "Por favor, insira o OTP antes de continuar.",
        messageType: MessageType.error,
      );
      return;
    }

    var body = {"email": email.trim(), "otp": otp.trim()};

    try {
      isLoading.value = true;
      var response = await _apiManager.post(ApiUrl.verifyOtp, body, false);
      isLoading.value = false;

      var message = jsonDecode(response.body);

      if (response.statusCode == 200) {
        CustomLoading.showNotification(
          message: "Verificação do OTP bem-sucedida para $email",
          messageType: MessageType.success,
        );

        Navigator.of(context).pushNamed(
          AppRoutes.changePasswordWord,
          arguments: {"email": email, "otp": otp.trim()},
        );
      } else {
        // Default message
        String errorMessage = "Falha na verificação do OTP";

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

        CustomLoading.showNotification(
          message: errorMessage,
          messageType: MessageType.error,
        );
      }
    } catch (e) {
      isLoading.value = false;

      CustomLoading.showNotification(
        message: "$e",
        messageType: MessageType.error,
      );
    }
  }

  Future verifyPasswordOtp(String otp, context, {required String email}) async {
    if (otp.trim().isEmpty) {
      CustomLoading.showNotification(
        message: "Por favor, insira o OTP antes de continuar.",
        messageType: MessageType.error,
      );
      return;
    }

    var body = {"email": email.trim(), "otp": otp.trim()};

    try {
      isLoading.value = true;
      var response = await _apiManager.post(ApiUrl.verifyOtp, body, false);
      isLoading.value = false;

      var message = {};
      try {
        message = jsonDecode(response.body);
      } catch (e) {
        message = {
          "error": {"message": "Resposta inválida do servidor"},
        };

      }

      if (response.statusCode == 200) {
        CustomLoading.showNotification(
          message: "Verificação do OTP bem-sucedida para $email",
          messageType: MessageType.success,
        );

        var token = message["token"];
        if (token != null) {
          StorageDesign.createItem(StorageDesign.token, token);
        }

        String? userStatus = message["user"]?["user_status"]
            ?.toString()
            .toLowerCase();
        if (userStatus != null) {
          StorageDesign.createItem("user_status", userStatus);
                    StorageDesign.createItem(StorageDesign.userType, userStatus);

        }

        if (userStatus == "cpf") {
          Navigator.of(context).pushNamed(AppRoutes.cpfProfile);
        } else if (userStatus == "cnpj") {
          Navigator.of(context).pushNamed(AppRoutes.cnpjProfile);

          // Get.offAllNamed(RouteNameV1.cnpjProfile, arguments: email);
        }
      }
    } catch (e) {
      isLoading.value = false;

      CustomLoading.showNotification(
        message: "$e",
        messageType: MessageType.error,
      );
    }
  }

  Future<void> signUp() async {
    try {
      _validateSignupForm();

      if (!isSignupFormValid.value) {
        CustomLoading.showNotification(
          message:
              "Por favor, preencha todos os campos obrigatórios corretamente.",
          messageType: MessageType.error,
        );
        return;
      }
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

      body.removeWhere(
        (key, value) => value == null || value.toString().isEmpty,
      );

      if (selectedRoleStatusIds.isNotEmpty) {
        body["category_id"] = selectedRoleStatusIds.toList();
      }

      isLoading.value = true;
      var response = await _apiManager.post(ApiUrl.signup, body, false);
      isLoading.value = false;

      final message = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        passwordController.clear();
        confirmPasswordController.clear();
        fullNameController.clear();
        phoneNumberController.clear();
        cpfController.clear();
        cnpjController.clear();
        tradeNameController.clear();
        motherNameController.clear();
        emailController.clear();
        addressController.clear();
        birthDateController.clear();
        cepController.clear();
        companyNameController.clear();
        legalRepNameController.clear();
        stateRegistrationController.clear();

        selectedRoleStatusIds.clear();
        selectedRolesNames.clear();

        selectedDocumentType.value = "";
        CustomLoading.showNotification(
          message: "Por favor, verifique seu e-mail usando o OTP enviado.",
          messageType: MessageType.success,
        );

        Get.to(() => SignUpOtpVerification(email: body["email"]));
      } else {
        String errorMessage = "Falha no cadastro";
        if (message["error"]?["details"] != null) {
          final details = message["error"]["details"] as Map<String, dynamic>;
          if (details.isNotEmpty) {
            errorMessage = details.values.first[0].toString();
          }
          debugPrint("📤 SIGNUP REQUEST BODY:");
          debugPrint(jsonEncode(body));
        } else if (message["error"]?["message"] != null) {
          errorMessage = message["error"]["message"].toString();
        }

        CustomLoading.showNotification(
          message: errorMessage,
          messageType: MessageType.error,
        );
      }
    } catch (e) {
      isLoading.value = false;
      CustomLoading.showNotification(
        message: "$e",
        messageType: MessageType.error,
      );
    }
  }

Future<void> getServiceCategory() async {
  try {
    final response = await _apiManager.read(ApiUrl.serviceCategory, false);

    final Map<String, dynamic> data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // Use safe casting and provide empty list as fallback
      final List<dynamic> categoriesJson = data['categories'] ?? [];
      
      userRoleList.value = categoriesJson
          .map((c) => CategoryModel.fromJson(c))
          .toList();
          
      // print("Categories loaded successfully: ${userRoleList.length}");
    } else {
      // Handle known API error messages
      String errorMessage = data["error"]?["message"] ?? "Falha ao buscar categorias";
      _showError(errorMessage);
    }
  } catch (e) {
    // This will now catch the SocketException strings from your ApiManager
    _showError(e.toString());
  }
}

// Helper to keep code DRY
void _showError(String message) {
  CustomLoading.showNotification(
    message: message.replaceFirst("Exception: ", ""), // Clean up the "Exception: " prefix
    messageType: MessageType.error,
  );
}

  Future uploadProfilePicNDoc() async {
    try {
      if (cnpjDoc == null || driverLicense == null || avatar == null) {
        CustomLoading.showNotification(
          message: "Todos os documentos são obrigatórios",
          messageType: MessageType.error,
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
        await http.MultipartFile.fromPath(
          "identifican_driver_license",
          driverLicense!.path,
        ),
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

      dynamic message;
      try {
        message = jsonDecode(response.body);
      } catch (e) {
        CustomLoading.showNotification(
          message: "Resposta JSON inválida",
          messageType: MessageType.error,
        );
        return;
      }

      // SUCCESS
      if (response.statusCode == 200 || response.statusCode == 201) {
        CustomLoading.showNotification(
          message: "Documentos enviados com sucesso",
          messageType: MessageType.error,
        );

        // Get.offAllNamed(RouteNameV1.bottomNav);
      }
      // FAILED
      else {
        String errorMsg = "Falha ao enviar";

        if (message is Map &&
            message.containsKey("error") &&
            message["error"].containsKey("message")) {
          errorMsg = message["error"]["message"];
        }

        CustomLoading.showNotification(
          message: errorMsg,
          messageType: MessageType.error,
        );
      }
    } catch (e) {
      isLoading.value = false;

      CustomLoading.showNotification(
        message: "$e",
        messageType: MessageType.error,
      );
    }
  }
}

class CategoryModel {
  final int id;
  final String name;

  CategoryModel({required this.id, required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(id: json['id'], name: json['name']);
  }
}
