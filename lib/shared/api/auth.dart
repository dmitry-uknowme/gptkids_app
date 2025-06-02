import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:gptkids_app/auth/model/user_model.dart';
import 'package:gptkids_app/shared/api/api.dart';

Future<UserModel> authLogin(String authValue) async {
  final client = ApiClient.client;
  final response = await client.post(
    '/user_device/auth/login',
    data: {'imei': authValue},
  );

  final Map<String, dynamic>? data = response.data;

  if (data == null) {
    throw Exception('Ошибка авторизации: ответ от сервера пустой.');
  }

  final userJson = data['user'];
  if (userJson == null) {
    throw Exception(
      'Ошибка авторизации: поле "user" не найдено в ответе сервера. Ответ: $data',
    );
  }

  final user = UserModel(
    userId: userJson['user_guid']?.toString() ?? '',
    parentUserId: userJson['parent_user_guid']?.toString() ?? '',
    telegramId: userJson['telegram_id']?.toString() ?? '',
    subscriptionTokens:
        userJson['subscription_total_tokens']?.toString() ?? '0',
  );
  return user;
}

// authLogin(String authValue) async {
//   final client = ApiClient.client;
//   final response = await client.post('/auth/login', data: {'imei': authValue});

//   final data = response.data;

//   // if (data == null || data['user'] == null) {
//   //   throw Exception('Ошибка авторизации: user не найден. Ответ сервера: $data');
//   // }

//   final userJson = data['user'];
//   final user = UserModel(
//     userId: userJson['user_guid'],
//     parentUserId: userJson['parent_user_guid'],
//     telegramId: userJson['telegram_id'],
//     subscriptionTokens: userJson['subscription_total_tokens'].toString(),
//   );
//   return user;
// }
