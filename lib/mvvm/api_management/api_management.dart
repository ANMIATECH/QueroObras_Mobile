import 'dart:io';

import 'package:http/http.dart' as http; // Keep http for Response and MultipartFile
abstract class ApiReuse {
  static String baseUrl = "https://test-api.dubballup.com/";
  Future<http.Response> post(
      String endpoint, Map<String, dynamic> body, bool bearerToken);
  Future<http.Response> read(String endpoint, bool bearerToken);
  Future<http.Response> readOnce(String endpoint, bool bearerToken);
  Future<http.Response> updateApi(
      String endpoint, Map<String, dynamic> body, bool bearerToken);
  Future<http.Response> updatePatch(
      String endpoint, Map<String, dynamic> body, bool bearerToken);
  Future<http.Response> delete(String endpoint, bool bearerToken);
  Future<http.StreamedResponse> uploadFileWithData({
    required String endpoint,
    required File file,
    required Map<String, String> data,
    required String fileField, // 👈 Add this
    bool bearerToken = true,
  });
}
