import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:serveeasy_app/app/data/services/dio_service/api_interceptor.dart';
import 'package:serveeasy_app/app/data/services/token_manager.dart';
import 'package:serveeasy_app/core/env/env.dart';

class DioBuilderResponse {
  Dio dio;
  Options dioOptions;

  DioBuilderResponse({required this.dio, required this.dioOptions});
}

class DioBuilder {
  Options _getCachedDioOptions() {
    return buildCacheOptions(
      const Duration(days: 30),
      forceRefresh: true,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 501;
        },
      ),
    );
  }

  Future<DioBuilderResponse> buildCachedDio({
    bool hasAuth = true,
    bool shouldQueue = false,
  }) async {
    final DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
    final Options dioOptions = _getCachedDioOptions();
    final String token = await TokenManager().getToken();
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: Env.currentEnv.baseUrl,
        connectTimeout: 15000,
        receiveTimeout: 15000,
        headers: hasAuth
            ? {
                'Authorization': 'Bearer $token',
                'Content-Type': 'application/json',
              }
            : {
                'Content-Type': 'application/json',
              },
      ),
    );
    dio.interceptors.add(DioInterceptor(dio));
    dio.interceptors.add(dioCacheManager.interceptor);
    if (shouldQueue) dio.interceptors.add(QueuedInterceptor());
    return DioBuilderResponse(dio: dio, dioOptions: dioOptions);
  }

  Future<DioBuilderResponse> buildNonCachedDio({
    bool hasAuth = false,
    bool shouldQueue = false,
  }) async {
    final Options dioOptions = _getDioOptions();
    final String token = await TokenManager().getToken();
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: Env.currentEnv.baseUrl,
        connectTimeout: 15000,
        receiveTimeout: 15000,
        headers: hasAuth
            ? {
                'Authorization': 'Bearer $token',
                'Content-Type': 'application/json',
              }
            : {
                'Content-Type': 'application/json',
              },
      ),
    );
    dio.interceptors.add(DioInterceptor(dio));
    if (shouldQueue) dio.interceptors.add(QueuedInterceptor());
    return DioBuilderResponse(dio: dio, dioOptions: dioOptions);
  }

  Options _getDioOptions() {
    return Options(
      followRedirects: false,
      validateStatus: (status) {
        return status! < 501;
      },
    );
  }
}
