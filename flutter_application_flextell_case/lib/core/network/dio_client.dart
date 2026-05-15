import 'package:dio/dio.dart';
import 'package:flutter_application_flextell_case/core/constants/api_constants.dart';

// For create an Dio Instance
class DioClient {
  static final Dio dioIntance = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      // The max time to wait while connecting to the server..
      connectTimeout: const Duration(seconds: 30),
      // The response wait time after the connection is established..
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json', // data format 
      },
    ),
  );
}