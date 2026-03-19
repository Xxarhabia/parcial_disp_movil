import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;

  DioClient()
    : dio = Dio(
      BaseOptions(
        baseUrl: "https://valorant-api.com/v1",
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        headers: {
          "Content-Type": "application/json",
        },
      ),
    ) {
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            print("${options.method} ${options.path}");
            return handler.next(options);
          },
          onResponse: (response, handler) {
            print("${response.statusCode}");
            return handler.next(response);
          },
          onError: (e, handler) {
            print("${e.message}");
            return handler.next(e);
          }
        )
      );
    }
}