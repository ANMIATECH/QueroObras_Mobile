import 'package:http/http.dart' as http;

import '../const/export.dart';

class ApiManager implements ApiReuse {
  @override
  Future<http.StreamedResponse> uploadFileWithData({
    required String endpoint,
    required File file,
    required Map<String, String> data,
    required String fileField, // 👈 dynamic field name for the file
    bool bearerToken = true,
  }) async {
    try {
      String token = bearerToken
          ? StorageDesign.readItem(StorageDesign.token)
          : "";

      final url = Uri.parse('${ApiReuse.baseUrl}$endpoint');

      final request = http.MultipartRequest('POST', url);

      // Add bearer token if needed
      if (bearerToken) {
        request.headers['Authorization'] = 'Bearer $token';
      }

      // Attach file with dynamic field name
      request.files.add(
        await http.MultipartFile.fromPath(
          fileField, // 👈 use the provided field name here
          file.path,
        ),
      );

      // Attach additional fields
      request.fields.addAll(data);

      // Send the request

      final response = await request.send();

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response;
      } else {
        return response;
      }
    } on SocketException {
      throw Exception("No Internet connection. Please check your network.");
    } on TimeoutException {
      throw Exception("Request timed out. Try again later.");
    } on HttpException catch (e) {
      throw Exception("HTTP Error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error occurred: $e");
    }
  }

  @override
  Future<http.Response> post(
    String endpoint,
    Map<String, dynamic> body,
    bool bearerToken,
  ) async {
    FocusManager.instance.primaryFocus?.unfocus();

    try {
      String token = bearerToken == false
          ? ""
          : StorageDesign.readItem(StorageDesign.token);

      final url = Uri.parse('${ApiReuse.baseUrl}$endpoint');
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',

        if (bearerToken == true) 'Authorization': 'Bearer $token',
      };

      final response = await http
          .post(url, headers: headers, body: jsonEncode(body))
          .timeout(const Duration(seconds: 15)); // Set a timeout

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response;
      } else {
        return response;
      }
    } on SocketException {
      throw Exception("No Internet connection. Please check your network.");
    } on TimeoutException {
      throw Exception("Request timed out. Try again later.");
    } on HttpException catch (e) {
      throw Exception("HTTP Error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error occurred: $e");
    }
  }

  @override
  Future<http.Response> read(
    String endpoint,
    bool bearerToken, [
    Map<String, String>?
    queryParameters, // Made optional with []// Parameters like page and per_page
  ]) async {
    String token = bearerToken == false
        ? ""
        : StorageDesign.readItem(StorageDesign.token);

    final url = Uri.parse(
      '${ApiReuse.baseUrl}$endpoint',
    ).replace(queryParameters: queryParameters);

    // print(url);

    final headers = {
      'Content-Type': 'application/json',
      'Accept-Language': 'pt',
      // 'User-Agent': d,
      if (bearerToken == true) 'Authorization': 'Bearer $token',
    };
    try {
      return await http.get(url, headers: headers);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<http.Response> readOnce(String endpoint, bool bearerToken) async {
    String token = bearerToken == false
        ? ""
        : StorageDesign.readItem(StorageDesign.token);

    final url = Uri.parse('${ApiReuse.baseUrl}$endpoint');

    final headers = {
      'Content-Type': 'application/json',
      // 'User-Agent': d,
      if (bearerToken) 'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(url, headers: headers);

      // If token is invalid or expired, logout
      if (response.statusCode == 401 || response.statusCode == 400) {
        StorageDesign.deleteItem(
          StorageDesign.token,
        ); // or specifically StorageManager.deleteItem(StorageManager.token);

        // Navigate to login screen
        // Get.offAllNamed(RouteNameV1.login); // Change route to your login route

        Get.snackbar(
          'Logged Out',
          "Session Expired",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<http.Response> updateApi(
    String endpoint,
    Map<String, dynamic> body,
    bool bearerToken,
  ) async {
    FocusManager.instance.primaryFocus?.unfocus();

    String token = bearerToken == false
        ? ""
        : StorageDesign.readItem(StorageDesign.token);

    final url = Uri.parse('${ApiReuse.baseUrl}$endpoint');
    final headers = {
      'Content-Type': 'application/json',
      // 'User-Agent': d,
      if (bearerToken == true) 'Authorization': 'Bearer $token',
    };
    try {
      return await http.put(url, headers: headers, body: jsonEncode(body));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<http.Response> updatePatch(
    String endpoint,
    Map<String, dynamic> body,
    bool bearerToken,
  ) async {
    FocusManager.instance.primaryFocus?.unfocus();

    String token = bearerToken == false
        ? ""
        : StorageDesign.readItem(StorageDesign.token);

    final url = Uri.parse('${ApiReuse.baseUrl}$endpoint');
    final headers = {
      'Content-Type': 'application/json',
      // 'User-Agent': d,
      if (bearerToken == true) 'Authorization': 'Bearer $token',
    };
    try {
      return await http.patch(url, headers: headers, body: jsonEncode(body));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<http.Response> delete(String endpoint, bool bearerToken) async {
    String token = bearerToken == false
        ? ""
        : StorageDesign.readItem(StorageDesign.token);
    final headers = {
      'Content-Type': 'application/json',
      // 'User-Agent': d,
      if (bearerToken == true) 'Authorization': 'Bearer $token',
    };
    final url = Uri.parse('${ApiReuse.baseUrl}$endpoint');
    try {
      return await http.delete(url, headers: headers);
    } catch (e) {
      rethrow;
    }
  }

  // 👈 New: Function for uploading multiple files
  Future<http.StreamedResponse> uploadMultipleFilesWithData({
    required String endpoint,
    required List<File> files, // List of files
    required Map<String, String> data,
    required String fileField, // Should be 'images[]'
    bool bearerToken = true,
  }) async {
    try {
      String token = bearerToken
          ? StorageDesign.readItem(StorageDesign.token)
          : "";

      final url = Uri.parse('${ApiReuse.baseUrl}$endpoint');

      final request = http.MultipartRequest('POST', url);

      // Add bearer token if needed
      if (bearerToken) {
        request.headers['Authorization'] = 'Bearer $token';
      }

      // Attach multiple files
      for (var file in files) {
        request.files.add(
          await http.MultipartFile.fromPath(
            fileField, // 'images[]'
            file.path,
          ),
        );
      }

      // Attach additional fields
      request.fields.addAll(data);

      // Send the request
      final response = await request.send();

      return response;
    } on SocketException {
      throw Exception("No Internet connection. Please check your network.");
    } on TimeoutException {
      throw Exception("Request timed out. Try again later.");
    } on HttpException catch (e) {
      throw Exception("HTTP Error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error occurred: $e");
    }
  }
}
