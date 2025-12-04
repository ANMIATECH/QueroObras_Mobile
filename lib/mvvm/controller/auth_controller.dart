import 'package:http/http.dart' as http;
import '../const/export.dart';
import 'package:file_picker/file_picker.dart';

class AuthController extends GetxController {
  final ApiManager _apiManager = ApiManager();
  final resetEmailController = TextEditingController();

  Rx<File?> profileImage = Rx<File?>(null);
  Rx<File?> documentImage = Rx<File?>(null);
  Rx<File?> cnpjDocumentImage = Rx<File?>(null);

  final ImagePicker picker = ImagePicker();

  Future<void> pickProfileImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      profileImage.value = File(picked.path);
    }
  }

  Future<void> pickDocumentImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      documentImage.value = File(picked.path);
    }
  }

  Future<void> pickCnpjDocumentImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'webp', 'bmp', 'tiff'],
      );

      if (result != null && result.files.single.path != null) {
        cnpjDocumentImage.value = File(result.files.single.path!); // 👈 FIXED
      } else {
      }
    } catch (e) {
      SnackbarUtil.showSnackbar(
        title: "Error",
        message: "Failed to pick file: $e",
        type: SnackbarType.error,
      );
    }
  }

  Future<void> pickCpfDocumentImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'webp', 'bmp', 'tiff'],
      );

      if (result != null && result.files.single.path != null) {
        documentImage.value = File(result.files.single.path!); // 👈 FIXED
      } else {
      }
    } catch (e) {
      SnackbarUtil.showSnackbar(
        title: "Error",
        message: "Failed to pick file: $e",
        type: SnackbarType.error,
      );
    }
  }

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
      var response = await _apiManager.read(ApiUrl.serviceCategory, false);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        var categories = data['categories'] as List<dynamic>? ?? [];

        // Safely map names and ignore nulls
        userRoleOptions.value = categories
            .map((cat) => (cat['name'] ?? '').toString())
            .where((name) => name.isNotEmpty)
            .toList();
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

  Future<void> getReformaeConstruoServiceCategory() async {
    try {
      var response = await _apiManager.read(ApiUrl.serviceCategory, false);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        var categories = data['categories'] as List<dynamic>? ?? [];

        // Safely map names and ignore nulls
        userRoleOptions.value = categories
            .map((cat) => (cat['name'] ?? '').toString())
            .where((name) => name.isNotEmpty)
            .toList();
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

  Future uploadProfilePicNDoc(dynamic context) async {
    try {
      if (profileImage.value == null || documentImage.value == null) {
        CustomLoading.showNotification(
          message: "Both profile picture and document are required",
          messageType: MessageType.error,
        );
        return;
      }

      isLoading.value = true;

      // Build full URL like in read()
      final url = Uri.parse('${ApiReuse.baseUrl}${ApiUrl.picNDoc}');

      var request = http.MultipartRequest('POST', url);

      // Add Authorization header
      String? token = StorageDesign.readItem(StorageDesign.token);
      if (token != null) {
        request.headers['Authorization'] = "Bearer $token";
      }

      // Attach files
      request.files.add(
        await http.MultipartFile.fromPath("avatar", profileImage.value!.path),
      );
      request.files.add(
        await http.MultipartFile.fromPath(
          "identifican_driver_license",
          documentImage.value!.path,
        ),
      );

      // Send request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      isLoading.value = false;

      dynamic message;
      try {
        message = jsonDecode(response.body);
      } catch (e) {
        CustomLoading.showNotification(
          message: "Invalid JSON returned by server",
          messageType: MessageType.error,
        );
        return;
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        CustomLoading.showNotification(
          message: "Documents uploaded successfully",
          messageType: MessageType.success,
        );
        Navigator.of(context).pushNamed(AppRoutes.bottomNavCpf);

        // Get.offAllNamed(RouteNameV1.bottomNavCpf);
      } else {
        String errorMsg = "Upload failed";

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

  Future uploadProfilePicNDocCnpj() async {
    try {
      if (profileImage.value == null || cnpjDocumentImage.value == null) {
        SnackbarUtil.showSnackbar(
          title: "Upload Failed",
          message: "Both profile picture and CNPJ document are required",
          type: SnackbarType.error,
        );
        return;
      }

      isLoading.value = true;

      // Build full URL
      final url = Uri.parse('${ApiReuse.baseUrl}${ApiUrl.picNDoc}');

      var request = http.MultipartRequest('POST', url);

      // Add Authorization header
      String? token = StorageDesign.readItem(StorageDesign.token);
      if (token != null) {
        request.headers['Authorization'] = "Bearer $token";
      }

      // Attach avatar and CNPJ document
      request.files.add(
        await http.MultipartFile.fromPath("avatar", profileImage.value!.path),
      );
      request.files.add(
        await http.MultipartFile.fromPath(
          "cnpj_document",
          cnpjDocumentImage.value!.path,
        ),
      );

      // Send request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      isLoading.value = false;

      dynamic message;
      try {
        message = jsonDecode(response.body);
      } catch (e) {
        SnackbarUtil.showSnackbar(
          title: "Upload Failed",
          message: "Invalid JSON returned by server",
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
        // Get.offAllNamed(RouteNameV1.bottomNav);
      } else {
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

      SnackbarUtil.showSnackbar(
        title: "Upload Failed",
        message: "$e",
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
  RxString selectedUserStatus = ''.obs;
  RxString selectedRoleStatus = ''.obs;
  RxString selectedDocumentType = ''.obs; // 'CPF' or 'CNPJ'

  final List<String> userStatusOptions = ['Prestador de serviço'];

  var userRoleOptions = <String>[].obs; // store category names

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
}
