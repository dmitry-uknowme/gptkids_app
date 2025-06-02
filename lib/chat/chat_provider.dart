import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:gptkids_app/chat/widgets/chat_action.dart';
import 'package:gptkids_app/shared/api/api.dart';
import 'package:gptkids_app/shared/api/message.dart';

class ChatProvider with ChangeNotifier {
  ApiClient apiClient = ApiClient();
  ChatActionModel _action = DEFAULT_CHAT_ACTION_LIST[0];
  ChatActionModel? get action => _action;

  // final List<MessageModel> _messages = [
  //   MessageModel(
  //     type: "TEXT",
  //     content:
  //         "Привет! Я GPTkids, твой персональный ИИ-ассистент. Чем я могу тебе помочь сегодня? Могу помочь с домашним заданием, ответить на вопросы или просто поболтать!",
  //     isUser: false,
  //     fileUrl: "",
  //   ),
  //   MessageModel(
  //     type: "TEXT",
  //     content: "Привет броууу",
  //     isUser: true,
  //     fileUrl: "",
  //   ),
  // ];
  final List<MessageModel> _messages = [];
  List<MessageModel> get messages => List.unmodifiable(_messages);

  // Future<void> setAction(ChatActionModel action) async {
  //   _action = action;
  //   await refetchMessages();
  //   // notifyListeners();
  // }

  void setAction(ChatActionModel action) {
    _action = action;
    Future.microtask(() => refetchMessages());
    notifyListeners(); // обновляем UI сразу
  }

  void addMessage(MessageModel message) {
    _messages.add(message);
  }

  Future<void> refetchMessages() async {
    final actionName = _action.name;
    final serverMessages = await apiClient.getMessages(actionName);
    _messages.clear();
    _messages.addAll(serverMessages.reversed);
    // _messages.addAll(serverMessages);
    notifyListeners();
  }

  // void updateLastBotMessage(String newText) {
  //   for (int i = _messages.length - 1; i >= 0; i--) {
  //     if (!_messages[i].isUser) {
  //       _messages[i] = MessageModel(text: newText, isUser: false);
  //       notifyListeners();
  //       break;
  //     }
  //   }
  // }

  // void sendMessage(String text) async {
  //   if (text.trim().isEmpty) return;

  //   // 1. Добавляем сообщение пользователя
  //   _messages.add(MessageModel(text: text, isUser: true));
  //   notifyListeners();

  //   // 2. Добавляем временное пустое сообщение от бота
  //   final botMessage = MessageModel(text: '', isUser: false);
  //   _messages.add(botMessage);
  //   notifyListeners();

  //   try {
  //     final stream = await apiClient.messageSendStream('MAIN', text);
  //     final buffer = StringBuffer();

  //     // await for (final chunk in stream
  //     //     .transform(utf8.decoder as StreamTransformer<Uint8List, dynamic>)
  //     //     .transform(const LineSplitter())) {
  //     //   final decoded = chunk.trim();

  //     await for (final chunk in stream
  //         .cast<List<int>>()
  //         .transform(utf8.decoder)
  //         .transform(const LineSplitter())) {
  //       final decoded = chunk.trim();

  //       if (decoded == '[DONE]') break;

  //       // Убираем префикс data: если есть
  //       final jsonString = decoded.replaceFirst(RegExp(r'^data:\s*'), '');
  //       try {
  //         final Map<String, dynamic> jsonData = json.decode(jsonString);
  //         final content = jsonData['choices']?[0]?['delta']?['content'];
  //         // print('JSON:   $content');

  //         if (content != null) {
  //           buffer.write(content);

  //           // Найдём и обновим последнее сообщение бота
  //           final index = _messages.indexOf(botMessage);
  //           if (index != -1) {
  //             _messages[index] = MessageModel(
  //               text: buffer.toString(),
  //               isUser: false,
  //             );
  //             notifyListeners();
  //             print(
  //               'Notified listeners with updated message: ${buffer.toString()}',
  //             );
  //           }
  //         }
  //       } catch (e) {
  //         // print('Ошибка парсинга JSON: $e $jsonString');
  //       }
  //     }
  //   } catch (e) {
  //     print('Ошибка при получении стрима: $e');
  //     // При ошибке можно вставить сообщение с ошибкой в чат
  //     _messages.add(
  //       MessageModel(
  //         text: 'Произошла ошибка при ответе бота. Попробуй ещё раз.',
  //         isUser: false,
  //       ),
  //     );
  //     notifyListeners();
  //   }
  // }
}
