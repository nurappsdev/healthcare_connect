import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import '../helpers/prefs_helper.dart';
import '../theme/app_constant.dart';
import 'api_constants.dart';
import 'error_response.dart';

class ApiClient {
  ApiClient._();

  static var client = http.Client();
  static const String noInternetMessage = "Can't connect to the internet!";
  static const int timeoutInSeconds = 30;
  static String bearerToken = "";

  static bool _isSuccess(int? code) =>
      code != null && code >= 200 && code < 300;

  //==========================================> Get Data <======================================
  static Future<ApiResponse> getData(
      String uri, {
        Map<String, dynamic>? query,
        Map<String, String>? headers,
      }) async {
    bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

    var mainHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');

      http.Response response = await client
          .get(
        Uri.parse(ApiConstants.baseUrl + uri),
        headers: headers ?? mainHeaders,
      )
          .timeout(const Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      debugPrint('------------${e.toString()}');
      return const ApiResponse(statusCode: 1, statusText: noInternetMessage);
    }
  }

  //==========================================> Post Data <======================================
  static Future<ApiResponse> postData(
      String uri,
      dynamic body, {
        Map<String, String>? headers,
      }) async {
    bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

    var mainHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    };

    try {
      debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
      debugPrint('====> API Body: $body');

      http.Response response = await client
          .post(
        Uri.parse(ApiConstants.baseUrl + uri),
        body: body is String ? body : jsonEncode(body),
        headers: headers ?? mainHeaders,
      )
          .timeout(const Duration(seconds: timeoutInSeconds));

      debugPrint(
        "==========> Response Post: ${response.statusCode}\n${response.body}",
      );
      return handleResponse(response, uri);
    } catch (e, s) {
      debugPrint("===> Error in postData: $e");
      debugPrint("===> Stack: $s");
      return const ApiResponse(statusCode: 1, statusText: noInternetMessage);
    }
  }

  //==========================================> Patch <======================================
  static Future<ApiResponse> patch(
      String uri,
      dynamic body, {
        Map<String, String>? headers,
      }) async {
    bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

    var mainHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
      debugPrint('====> API Body: $body');

      http.Response response = await client
          .patch(
        Uri.parse(ApiConstants.baseUrl + uri),
        body: body is String ? body : jsonEncode(body),
        headers: headers ?? mainHeaders,
      )
          .timeout(const Duration(seconds: timeoutInSeconds));
      debugPrint("==========> Response Patch: ${response.statusCode}");
      return handleResponse(response, uri);
    } catch (e, s) {
      debugPrint("===> $e");
      debugPrint("===> $s");
      return const ApiResponse(statusCode: 1, statusText: noInternetMessage);
    }
  }

  //==========================================> Post Multipart Data <======================================
  static Future<ApiResponse> postMultipartData(
      String uri,
      Map<String, String> body, {
        required List<MultipartBody> multipartBody,
        Map<String, String>? headers,
      }) async {
    try {
      bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

      // Multipart-e Content-Type manually set kora lage na,
      // package nije boundary soho set kore dey.
      var mainHeaders = {
        'Authorization': 'Bearer $bearerToken',
      };

      debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
      debugPrint('====> API Body: $body with ${multipartBody.length} picture');

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiConstants.baseUrl + uri),
      );
      request.headers.addAll(headers ?? mainHeaders);
      for (MultipartBody element in multipartBody) {
        request.files.add(
          await http.MultipartFile.fromPath(element.key, element.file.path),
        );
      }
      request.fields.addAll(body);

      http.Response response =
      await http.Response.fromStream(await request.send());
      return handleResponse(response, uri);
    } catch (e) {
      return const ApiResponse(statusCode: 1, statusText: noInternetMessage);
    }
  }

  //==========================================> Put Data <======================================
  static Future<ApiResponse> putData(
      String uri,
      dynamic body, {
        Map<String, String>? headers,
      }) async {
    bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

    var mainHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
      debugPrint('====> API Body: $body');

      http.Response response = await client
          .put(
        Uri.parse(ApiConstants.baseUrl + uri),
        body: body is String ? body : jsonEncode(body),
        headers: headers ?? mainHeaders,
      )
          .timeout(const Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return const ApiResponse(statusCode: 1, statusText: noInternetMessage);
    }
  }

  //==========================================> Put Multipart Data <======================================
  static Future<ApiResponse> putMultipartData(
      String uri,
      Map<String, String> body, {
        List<MultipartBody>? multipartBody,
        List<MultipartListBody>? multipartListBody,
        Map<String, String>? headers,
      }) async {
    try {
      bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

      var mainHeaders = {
        'Authorization': 'Bearer $bearerToken',
      };

      debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
      debugPrint(
          '====> API Body: $body with ${multipartBody?.length ?? 0} picture');

      var request = http.MultipartRequest(
        'PUT',
        Uri.parse(ApiConstants.baseUrl + uri),
      );
      request.fields.addAll(body);

      if (multipartBody != null && multipartBody.isNotEmpty) {
        for (final element in multipartBody) {
          debugPrint("path : ${element.file.path}");
          final String? mimeType = mime(element.file.path);
          request.files.add(
            http.MultipartFile(
              element.key,
              element.file.readAsBytes().asStream(),
              element.file.lengthSync(),
              filename: element.file.path.split('/').last,
              contentType:
              mimeType != null ? MediaType.parse(mimeType) : null,
            ),
          );
        }
      }
      request.headers.addAll(headers ?? mainHeaders);

      http.StreamedResponse streamed = await request.send();
      final content = await streamed.stream.bytesToString();
      debugPrint('====> API Response: [${streamed.statusCode}] $uri\n$content');

      dynamic decoded;
      try {
        decoded = json.decode(content);
      } catch (_) {
        decoded = content;
      }

      return ApiResponse(
        statusCode: streamed.statusCode,
        statusText: streamed.reasonPhrase,
        body: decoded,
        bodyString: content,
      );
    } catch (e) {
      debugPrint("====> putMultipart error: $e");
      return const ApiResponse(statusCode: 1, statusText: noInternetMessage);
    }
  }

  //==========================================> Patch Multipart Data <======================================
  static Future<ApiResponse> patchMultipartData(
      String uri,
      Map<String, String> body, {
        List<MultipartBody>? multipartBody,
        List<MultipartListBody>? multipartListBody,
        Map<String, String>? headers,
      }) async {
    try {
      bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

      var mainHeaders = {
        'Authorization': 'Bearer $bearerToken',
      };

      debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
      debugPrint(
          '====> API Body: $body with ${multipartBody?.length ?? 0} picture');

      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse(ApiConstants.baseUrl + uri),
      );
      request.fields.addAll(body);

      if (multipartBody != null && multipartBody.isNotEmpty) {
        for (final element in multipartBody) {
          debugPrint("path : ${element.file.path}");
          final String? mimeType = mime(element.file.path);
          request.files.add(
            http.MultipartFile(
              element.key,
              element.file.readAsBytes().asStream(),
              element.file.lengthSync(),
              filename: element.file.path.split('/').last,
              contentType:
              mimeType != null ? MediaType.parse(mimeType) : null,
            ),
          );
        }
      }
      request.headers.addAll(headers ?? mainHeaders);

      http.StreamedResponse streamed = await request.send();
      final content = await streamed.stream.bytesToString();
      debugPrint('====> API Response: [${streamed.statusCode}] $uri\n$content');

      dynamic decoded;
      try {
        decoded = json.decode(content);
      } catch (_) {
        decoded = content;
      }

      return ApiResponse(
        statusCode: streamed.statusCode,
        statusText: streamed.reasonPhrase,
        body: decoded,
        bodyString: content,
      );
    } catch (e) {
      debugPrint("====> patchMultipart error: $e");
      return const ApiResponse(statusCode: 1, statusText: noInternetMessage);
    }
  }

  //==========================================> Delete Data <======================================
  static Future<ApiResponse> deleteData(
      String uri, {
        Map<String, String>? headers,
        dynamic body,
      }) async {
    bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

    var mainHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      debugPrint('====> API Call: $uri\nHeader: ${headers ?? mainHeaders}');
      debugPrint('====> API Call: $uri\n Body: $body');

      http.Response response = await client
          .delete(
        Uri.parse(ApiConstants.baseUrl + uri),
        headers: headers ?? mainHeaders,
        body: body is String ? body : (body != null ? jsonEncode(body) : null),
      )
          .timeout(const Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return const ApiResponse(statusCode: 1, statusText: noInternetMessage);
    }
  }

  //==========================================> Handle Response <======================================
  static ApiResponse handleResponse(http.Response response, String uri) {
    dynamic body;
    try {
      body = jsonDecode(response.body);
    } catch (e) {
      debugPrint(e.toString());
    }

    ApiResponse apiResponse = ApiResponse(
      body: body ?? response.body,
      bodyString: response.body.toString(),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );

    final success = _isSuccess(apiResponse.statusCode);

    if (!success && apiResponse.body != null && apiResponse.body is! String) {
      ApiResponse errorResponse = ApiResponse.fromJson(apiResponse.body);
      apiResponse = ApiResponse(
        statusCode: apiResponse.statusCode,
        body: apiResponse.body,
        statusText: errorResponse.statusText,
      );
    } else if (!success && apiResponse.body == null) {
      apiResponse =
      const ApiResponse(statusCode: 0, statusText: noInternetMessage);
    }

    debugPrint(
      '====> API Response: [${apiResponse.statusCode}] $uri\n${apiResponse.body}',
    );
    return apiResponse;
  }
}

class MultipartBody {
  String key;
  File file;
  MultipartBody(this.key, this.file);
}

class MultipartListBody {
  String key;
  String value;
  MultipartListBody(this.key, this.value);
}