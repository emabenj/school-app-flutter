import "dart:convert";
import "dart:io";
import "package:colegio_bnnm/util/constants/api_constants.dart";
import "package:colegio_bnnm/util/exceptions/api_auth_exceptions.dart";
import "package:colegio_bnnm/util/http/detail_model.dart";
import "package:flutter/foundation.dart";
import "package:http/http.dart" as http;
import "package:image_picker/image_picker.dart";

class BHttpHelper {
  static const _baseUrl = APIConstants.baseUrl;

  static Future<dynamic> get(String endpoint,
      {String token = "", bool isList = false}) async {
    final response = await http.get(
      Uri.parse("$_baseUrl/$endpoint"),
      headers: token.isEmpty
          ? {"Content-Type": "application/json"}
          : {"Authorization": "Bearer $token"},
    );
    return isList ? _handleListResponse(response) : _handleResponse(response);
  }

  static Future<dynamic> post(String endpoint, dynamic data,
      {String token = "", XFile? img, bool isList = false}) async {
    if (img != null) {
      var request =
          http.MultipartRequest('POST', Uri.parse("$_baseUrl/$endpoint"));
      request.headers.addAll({
        "Content-Type": "multipart/form-data",
        "Authorization": "Bearer $token"
      });
      data.forEach((key, value) {
        request.fields[key] = value.toString();
      });
      if (kIsWeb) {
        final byteData = await img.readAsBytes();
        final multipartFile = http.MultipartFile.fromBytes('imagen', byteData,
            filename: img.name);
        request.files.add(multipartFile);
      } else {
        final imagen = File(img.path);
        final stream = http.ByteStream(imagen.openRead());
        // stream.cast();
        final length = await img.length();
        final multiport =
            http.MultipartFile("imagen", stream, length, filename: img.name);
        request.files.add(multiport);
      }
      // Enviar la petición
      final streamedResponse = await request.send();
      // Procesar la respuesta
      final response = await http.Response.fromStream(streamedResponse);
      return isList ? _handleListResponse(response) : _handleResponse(response);
    } else {
      final response = await http.post(Uri.parse("$_baseUrl/$endpoint"),
          headers: token.isEmpty
              ? {"Content-Type": "application/json"}
              : {
                  "Content-Type": "application/json",
                  "Authorization": "Bearer $token"
                },
          body: json.encode(data));
      return isList ? _handleListResponse(response) : _handleResponse(response);
    }
  }

  static Future<Map<String, dynamic>> put(String endpoint, dynamic data,
      {String token = "", String? img}) async {
    final response = await http.put(Uri.parse("$_baseUrl/$endpoint"),
        headers: token.isEmpty
            ? {"Content-Type": "application/json"}
            : {
                "Content-Type": "application/json",
                "Authorization": "Bearer $token"
              },
        body: json.encode(data));
    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> patch(String endpoint, dynamic data,
      {String token = ""}) async {
    final response = await http.patch(Uri.parse("$_baseUrl/$endpoint"),
        headers: token.isEmpty
            ? {"Content-Type": "application/json"}
            : {
                "Content-Type": "application/json",
                "Authorization": "Bearer $token"
              },
        body: json.encode(data));
    return _handleResponse(response);
  }

  static Future<dynamic> delete(String endpoint, {String token = ""}) async {
    return await http.delete(Uri.parse("$_baseUrl/$endpoint"),
        headers: token.isEmpty
            ? {"Content-Type": "application/json"}
            : {
                "Content-Type": "application/json",
                "Authorization": "Bearer $token"
              });
    // return _handleResponse(response);
  }

  static Map<String, dynamic> _handleResponse(http.Response response) {
    final decodedJson = utf8.decode(response.bodyBytes);
    if ([200, 201, 204].contains(response.statusCode)) {
      final responseData = json.decode(decodedJson);
      return responseData;
    } else if ([404, 400].contains(response.statusCode)) {
      final detailError = decodedJson.contains("details")
          ? DetailModel.fromJson(json.decode(decodedJson)).detail
          : decodedJson;
      throw BApiAuthException(detailError);
    } else if (response.statusCode == 401) {
      throw Exception("Refresh token");
    } else {
      throw Exception("Failed to load data: ${response.statusCode}");
    }
  }

  static List<Map<String, dynamic>> _handleListResponse(
      http.Response response) {
    final decodedJson = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200 ||
        response.statusCode == 204 ||
        response.statusCode == 201) {
      final List<dynamic> jsonList = json.decode(decodedJson);
      return jsonList.map((item) {
        if (item is Map<String, dynamic>) {
          return item;
        } else {
          throw Exception("El JSON recibido no es una lista de mapas.");
        }
      }).toList();
    } else if (response.statusCode == 401) {
      throw Exception("Refresh token para listar");
    } else {
      throw Exception("Failed to load data: ${response.statusCode}");
    }
  }
}
