import 'dart:convert';
import 'dart:typed_data';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:gptkids_app/auth/model/user_model.dart';
import 'package:gptkids_app/shared/api/message.dart' as messageApi;
import 'package:gptkids_app/shared/api/auth.dart' as authApi;
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class ApiClient {
  static final CookieJar cookieJar = CookieJar();

  static final Dio _client =
      Dio()
        // ..options.baseUrl = 'http://193.227.240.209:5000'
        ..options.baseUrl = 'http://193.227.240.209:5000/'
        ..options.followRedirects = false
        ..options.validateStatus = ((status) => status != null && status < 500)
        ..interceptors.addAll([CookieManager(cookieJar), _AuthInterceptor()]);

  static Dio get client => _client;

  Future<UserModel> authLogin(String authValue) {
    return authApi.authLogin(authValue);
  }

  Future<List<messageApi.MessageModel>> getMessages(String activityName) {
    return messageApi.getMessages(activityName);
  }
}

class _AuthInterceptor extends Interceptor {
  @override
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Если статус не 200 (или не 2xx), кидаем ошибку с данными из ответа
    if (response.statusCode == null ||
        response.statusCode! < 200 ||
        response.statusCode! >= 300) {
      // Можно распарсить тело, если оно JSON — response.data уже обычно Map или List
      final errorData = response.data;
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          error:
              'HTTP error -> ${response.statusCode} Data -> ${jsonEncode(response.data)}',
        ),
        true,
      );
    } else {
      // Всё ок — пропускаем дальше
      handler.next(response);
    }
  }

  // @override
  // void onError(DioException err, ErrorInterceptorHandler handler) async {
  //   if (err.response?.statusCode == 401) {
  //     try {
  //       final response = await ApiClient.client.fetch(err.requestOptions);
  //       return handler.resolve(response);
  //     } catch (_) {
  //       return handler.next(err);
  //     }
  //   } else {
  //     throw DioException(
  //       // requestOptions: RequestOptions(baseUrl: err.response, data: err.response?.data),
  //       requestOptions: err.requestOptions,
  //     );
  //     return handler.next(err);
  //   }
  // }
}
