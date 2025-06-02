import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gptkids_app/auth/model/user_model.dart';
import 'package:gptkids_app/welcome/widgets/language_select.dart';

class AppProvider with ChangeNotifier {
  String _selectedLanguageCode = DEFAULT_LANGUAGE_LIST.first.code;
  get selectedLanguageCode => _selectedLanguageCode;

  String? _authMethod;
  get authMethod => _authMethod;

  String? _authValue;
  get authValue => _authValue;

  UserModel? _user;
  get user => _user;

  File? _userAvatar;
  get userAvatar => _userAvatar;

  void setLanguageCode(String code) {
    _selectedLanguageCode = code;
    notifyListeners();
  }

  void setAuthMethod(String value) {
    _authMethod = value;
    notifyListeners();
  }

  void setAuthValue(String value) {
    _authValue = value;
    notifyListeners();
  }

  void setUserAvatar(File avatar) {
    _userAvatar = avatar;
    notifyListeners();
  }

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  // void sendMessage(String text) {
  //   if (text.trim().isEmpty) return;

  //   _messages.add(MessageModel(text: text, isUser: true));
  //   notifyListeners();

  //   Future.delayed(Duration(seconds: 1), () {
  //     _messages.add(MessageModel(text: 'Ответ на "$text"', isUser: false));
  //     notifyListeners();
  //   });
  // }
}
