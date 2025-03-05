import 'dart:developer' as developer;
import 'package:dio/dio.dart';

class ApiClient {
  ApiClient({required this.baseUrl}) {
    _initializeDio();
  }

  late Dio _dio;
  final String baseUrl;

  void _initializeDio() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      // Configure to not throw on 429 status
      validateStatus: (status) {
        return status != null &&
            (status >= 200 && status < 300 || status == 429);
      },
    ));

    // dio interceptor
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        developer.log(
          'REQUEST[${options.method}] => PATH: ${options.path}',
          name: 'ApiClient',
        );
        return handler.next(options);
      },
      onResponse: (response, handler) {
        developer.log(
          'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
          name: 'ApiClient',
        );
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        developer.log(
          'ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}',
          name: 'ApiClient',
          error: e,
        );
        return handler.next(e);
      },
    ));
  }

  // All HTTP methods
  Future<ApiResponse> request({
    required String path,
    required HttpMethod method,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      late Response<dynamic> response;

      if (headers != null) {
        _dio.options.headers.addAll(headers);
      }

      switch (method) {
        case HttpMethod.get:
          response = await _dio.get(
            path,
            queryParameters: queryParameters,
          );
        case HttpMethod.post:
          response = await _dio.post(
            path,
            data: data,
            queryParameters: queryParameters,
          );
        case HttpMethod.put:
          response = await _dio.put(
            path,
            data: data,
            queryParameters: queryParameters,
          );
        case HttpMethod.delete:
          response = await _dio.delete(
            path,
            data: data,
            queryParameters: queryParameters,
          );
      }

      if (response.statusCode == 429) {
        return _handle429Error(response);
      }

      // Response
      return _processApiResponse(response);
    } on DioException catch (e) {
      // Dio Errors
      return _handleDioError(e);
    } catch (e) {
      // Unexpected Errors
      return ApiResponse(
        statusCode: 500,
        isSuccess: false,
        message: 'An unexpected error occurred: $e',
      );
    }
  }

  ApiResponse _handle429Error(Response<dynamic> response) {
    var errorMessage = 'Too Many Requests';
    dynamic errorDetails;

    // Error message from response
    if (response.data is Map) {
      final messageKeys = ['Message', 'message', 'error', 'detail'];
      for (final key in messageKeys) {
        if (response.data[key] != null) {
          errorMessage = response.data[key].toString();
          break;
        }
      }

      errorDetails = response.data;
    }

    final retryAfter = response.headers.value('Retry-After');

    // Log detailed 429 error information
    developer.log(
      'Rate Limit Exceeded: $errorMessage',
      name: 'ApiClient',
      error: {
        'Retry-After': retryAfter,
        'Error Details': errorDetails,
      },
    );

    return ApiResponse(
      statusCode: 429,
      data: errorDetails,
      isSuccess: false,
      message: errorMessage,
      additionalInfo: {
        'retryAfter': retryAfter,
      },
    );
  }

  ApiResponse _processApiResponse(Response<dynamic> response) {
    final responseData = response.data;
    var isSuccess = false;
    String? message;
    dynamic data;

    if (responseData is Map) {
      if (responseData.containsKey('Data')) {
        final dataContent = responseData['Data'];

        if (dataContent is Map) {
          // For Result
          isSuccess = dataContent['Result'] != null ||
              dataContent['Message']?.toLowerCase() == 'success';

          // For Message
          message = dataContent['Message'] as String;

          data = dataContent['Result'] ?? dataContent;
        } else {
          // If Data is not a map, use it directly
          data = dataContent;
          isSuccess = response.statusCode == 200;
          message = 'Success';
        }
      } else if (responseData.containsKey('Status') &&
          responseData.containsKey('Message')) {
        isSuccess = responseData['Status'] == true;
        message = responseData['Message'] as String;
        data = responseData;
      }
      // Fallback for other map structures
      else {
        isSuccess = response.statusCode == 200;
        message = 'Success';
        data = responseData;
      }
    }
    // Fallback for non-map responses
    else {
      isSuccess = response.statusCode == 200;
      message = 'Success';
      data = responseData;
    }

    return ApiResponse(
      statusCode: response.statusCode ?? 200,
      data: data,
      isSuccess: isSuccess,
      message: message,
    );
  }

  // Error handling method
  ApiResponse _handleDioError(DioException e) {
    String errorMessage;

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        errorMessage = 'Connection timeout';
      case DioExceptionType.badResponse:
        final response = e.response;
        errorMessage = _extractErrorMessage(response);
      case DioExceptionType.cancel:
        errorMessage = 'Request cancelled';
      case DioExceptionType.unknown:
        errorMessage = 'Network error';
      case DioExceptionType.badCertificate:
        errorMessage = 'SSL Certificate error';
      case DioExceptionType.connectionError:
        errorMessage = 'An Error Occured';
    }

    return ApiResponse(
      statusCode: e.response?.statusCode ?? 500,
      data: e.response?.data,
      isSuccess: false,
      message: errorMessage,
    );
  }

  // Error message method
  String _extractErrorMessage(Response<dynamic>? response) {
    if (response?.data is Map) {
      final messageKeys = ['Message', 'message', 'error', 'detail'];
      for (final key in messageKeys) {
        if (response!.data[key] != null) {
          return response.data[key].toString();
        }
      }
    }

    switch (response?.statusCode) {
      case 400:
        return 'Bad Request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not Found';
      case 429:
        return 'Too Many Requests';
      case 500:
        return 'Internal Server Error';
      default:
        return 'Unknown error occurred';
    }
  }
}

// HTTP enums
enum HttpMethod {
  get,
  post,
  put,
  delete,
}

// Custom response class to standardize API responses
class ApiResponse {
  ApiResponse({
    required this.statusCode,
    required this.isSuccess,
    this.data,
    this.message,
    this.additionalInfo,
  });
  final int statusCode;
  final dynamic data;
  final bool isSuccess;
  final String? message;
  final Map<String, dynamic>? additionalInfo;
}
