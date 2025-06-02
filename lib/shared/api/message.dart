import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:gptkids_app/shared/api/api.dart';
import 'package:json_annotation/json_annotation.dart';

enum Role { USER, ASSISTANT }

@JsonSerializable()
class MessageModel {
  final String type;
  final String content;
  final String? fileUrl;
  final Role role;

  MessageModel({
    required this.type,
    required this.content,
    this.fileUrl,
    required this.role,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      content: json['content'] ?? '',
      type: json['type'] ?? '',
      fileUrl: json['file_url'] ?? '',
      role: _parseRole(json['ai_role']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'content': content,
      'file_url': fileUrl,
      'ai_role': role.name,
    };
  }

  static Role _parseRole(dynamic value) {
    switch (value) {
      case 'USER':
        return Role.USER;
      case 'ASSISTANT':
        return Role.ASSISTANT;
      default:
        return Role.ASSISTANT;
    }
  }
}

Stream<String> messageSendStream(String activityName, String message) async* {
  final client = ApiClient.client;
  final response = await client.post<ResponseBody>(
    '/v2/chats/$activityName/ai_message/send',
    data: {'content': message},
    options: Options(responseType: ResponseType.stream),
  );

  final stream = response.data?.stream;
  if (stream == null) {
    throw Exception('Поток пустой');
  }

  final utf8Stream = stream
      .cast<List<int>>() // преобразуем в List<int>
      .transform(utf8.decoder) // теперь можем декодировать
      .transform(const LineSplitter()); // разбиваем на строки

  await for (final line in utf8Stream) {
    try {
      final jsonData = jsonDecode(line);
      print("json: $jsonData");
      // final content = jsonData['content'];
      final content = jsonData['choices'][0]['delta']['content'];
      if (content != null) {
        yield content.toString();
      }
    } catch (e) {
      // yield line;
    }
  }
}

Future<List<MessageModel>> getMessages(String activityName) async {
  final client = ApiClient.client;
  final response = await client.get('/chats/$activityName/messages');
  final data = response.data as Map<String, dynamic>;
  final List<dynamic> rawMessages = data['messages'];

  final messages =
      rawMessages
          .map((item) => MessageModel.fromJson(item as Map<String, dynamic>))
          .toList();
  return messages;
}
