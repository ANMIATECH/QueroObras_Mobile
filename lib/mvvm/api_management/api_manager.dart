import 'package:http/http.dart' as http;
import '../const/export.dart';

class ApiManager implements ApiReuse {
  /// Helper logic to validate token presence before executing requests
  String _getValidatedToken(bool bearerToken) {
    if (!bearerToken) return "";

    final tokenVerifcation = StorageDesign.validKey(StorageDesign.token);
    if (!tokenVerifcation) {
      return "no token".toLowerCase();
    }
    final token = StorageDesign.readItem(StorageDesign.token);

    return token.toString();
  }

  // --- MULTIPART METHODS ---
  /// Returns true if we can proceed, false if we should block.
  bool _isAuthValid(bool bearerToken, String token) {
    if (bearerToken && token.isEmpty) {
      Get.snackbar(
        'Autenticação necessária',
        "Por favor, faça login para continuar",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return false;
    }
    return true;
  }

  @override
  Future<http.StreamedResponse> uploadFileWithData({
    required String endpoint,
    required File file,
    required Map<String, String> data,
    required String fileField,
    bool bearerToken = true,
  }) async {
    try {
      final token = _getValidatedToken(bearerToken);
      if (token == "no token".toLowerCase()) {
        if (!_isAuthValid(bearerToken, token)) {
          // Return a empty StreamedResponse with 401 code
          return http.StreamedResponse(const Stream.empty(), 401);
        }
      } // STOP: Don't run HTTP
      final url = Uri.parse('${ApiReuse.baseUrl}$endpoint');
      final request = http.MultipartRequest('POST', url);

      request.headers['Accept-Language'] = 'pt';
      if (bearerToken) {
        request.headers['Authorization'] = 'Bearer $token';
      }

      request.files.add(
        await http.MultipartFile.fromPath(fileField, file.path),
      );
      request.fields.addAll(data);

      return await request.send();
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<http.StreamedResponse> uploadMultipleFilesWithData({
    required String endpoint,
    required List<File> files,
    required Map<String, String> data,
    required String fileField,
    bool bearerToken = true,
  }) async {
    try {
      final token = _getValidatedToken(bearerToken);
      if (token == "no token".toLowerCase()) {
        if (!_isAuthValid(bearerToken, token)) {
          // Return a empty StreamedResponse with 401 code
          return http.StreamedResponse(const Stream.empty(), 401);
        }
      } // STOP: Don't run HTTP
      final url = Uri.parse('${ApiReuse.baseUrl}$endpoint');
      final request = http.MultipartRequest('POST', url);

      request.headers['Accept-Language'] = 'pt'; // ✅ Add Portuguese
      if (bearerToken) {
        request.headers['Authorization'] = 'Bearer $token';
      }

      for (var file in files) {
        request.files.add(
          await http.MultipartFile.fromPath(fileField, file.path),
        );
      }

      request.fields.addAll(data);
      return await request.send();
    } catch (e) {
      return _handleError(e);
    }
  }

  // --- STANDARD HTTP METHODS ---

  @override
  Future<http.Response> post(
    String endpoint,
    Map<String, dynamic> body,
    bool bearerToken,
  ) async {
    FocusManager.instance.primaryFocus?.unfocus();
    try {
      final token = _getValidatedToken(bearerToken);
      if (token == "no token".toLowerCase()) {
        if (!_isAuthValid(bearerToken, token)) {
          // Return a empty StreamedResponse with 401 code
          return http.Response('{"error": "Unauthorized"}', 401);
        }
      } // STOP: Don't run HTTP
      final url = Uri.parse('${ApiReuse.baseUrl}$endpoint');

      return await http
          .post(
            url,
            headers: _buildHeaders(bearerToken, token,language: 'pt'),
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 15));
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<http.Response> read(
    String endpoint,
    bool bearerToken, [
    Map<String, String>? queryParameters,
  ]) async {
    try {
      final token = _getValidatedToken(bearerToken);
      if (token == "no token".toLowerCase()) {
        if (!_isAuthValid(bearerToken, token)) {
          // Return a empty StreamedResponse with 401 code
          return http.Response('{"error": "Unauthorized"}', 401);
        }
      } // STOP: Don't run HTTP
      final url = Uri.parse(
        '${ApiReuse.baseUrl}$endpoint',
      ).replace(queryParameters: queryParameters);
print("calling url: $url");
print("using token: $token");
      return await http.get(
        url,
        headers: _buildHeaders(bearerToken, token, language: 'pt'),
      );
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<http.Response> readOnce(String endpoint, bool bearerToken) async {
    try {
      final token = _getValidatedToken(bearerToken);
      if (token == "no token".toLowerCase()) {
        if (!_isAuthValid(bearerToken, token)) {
          // Return a empty StreamedResponse with 401 code
          return http.Response('{"error": "Unauthorized"}', 401);
        }
      } // STOP: Don't run HTTP
      final url = Uri.parse('${ApiReuse.baseUrl}$endpoint');
      final response = await http.get(
        url,
        headers: _buildHeaders(bearerToken, token,language: 'pt'),
      );

      if (response.statusCode == 401 || response.statusCode == 400) {
        StorageDesign.deleteItem(StorageDesign.token);
        Get.snackbar(
          'Sessão encerrada',
          "Sessão expirada",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
      return response;
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<http.Response> updateApi(
    String endpoint,
    Map<String, dynamic> body,
    bool bearerToken,
  ) async {
    FocusManager.instance.primaryFocus?.unfocus();
    try {
      final token = _getValidatedToken(bearerToken);
      if (token == "no token".toLowerCase()) {
        if (!_isAuthValid(bearerToken, token)) {
          // Return a empty StreamedResponse with 401 code
          return http.Response('{"error": "Unauthorized"}', 401);
        }
      } // STOP: Don't run HTTP
      return await http.put(
        Uri.parse('${ApiReuse.baseUrl}$endpoint'),
        headers: _buildHeaders(bearerToken, token,language: 'pt'),
        body: jsonEncode(body),
      );
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<http.Response> updatePatch(
    String endpoint,
    Map<String, dynamic> body,
    bool bearerToken,
  ) async {
    FocusManager.instance.primaryFocus?.unfocus();
    try {
      final token = _getValidatedToken(bearerToken);
      if (token == "no token".toLowerCase()) {
        if (!_isAuthValid(bearerToken, token)) {
          // Return a empty StreamedResponse with 401 code
          return http.Response('{"error": "Unauthorized"}', 401);
        }
      } // STOP: Don't run HTTP
      return await http.patch(
        Uri.parse('${ApiReuse.baseUrl}$endpoint'),
        headers: _buildHeaders(bearerToken, token,language: 'pt'),
        body: jsonEncode(body),
      );
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<http.Response> delete(String endpoint, bool bearerToken) async {
    try {
      final token = _getValidatedToken(bearerToken);
      if (token == "no token".toLowerCase()) {
        if (!_isAuthValid(bearerToken, token)) {
          // Return a empty StreamedResponse with 401 code
          return http.Response('{"error": "Unauthorized"}', 401);
        }
      } // STOP: Don't run HTTP
      return await http.delete(
        Uri.parse('${ApiReuse.baseUrl}$endpoint'),
        headers: _buildHeaders(bearerToken, token,language: 'pt'),
      );
    } catch (e) {
      return _handleError(e);
    }
  }

  // --- HELPERS ---

  Map<String, String> _buildHeaders(
    bool bearerToken,
    String token, {
    String? language,
  }) {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (language != null) 'Accept-Language': language,
      if (bearerToken) 'Authorization': 'Bearer $token',
    };
  }

  dynamic _handleError(dynamic e) {
    if (e is SocketException) {
      throw Exception("Sem conexão com a Internet. Verifique sua rede.");
    } else if (e is TimeoutException) {
      throw Exception("A solicitação expirou. Tente novamente mais tarde.");
    } else if (e is HttpException) {
      throw Exception("Erro HTTP: ${e.message}");
    } else {
      // This catches the "Authentication Required" from _getValidatedToken
      throw Exception(e.toString().replaceAll("Exception: ", ""));
    }
  }
}
