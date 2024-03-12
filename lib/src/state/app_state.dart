import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../interfaces/registry_key.dart';

// -------------
// App
// -------------

// 目的: グローバル変数
class AppState extends ChangeNotifier {
  // pageIndex
  int _pageIndex = 0;

  int get pageIndex => _pageIndex;

  set pageIndex(int index) {
    _pageIndex = index;

    // 通知する
    notifyListeners();
  }

  // currentTodoId
  int _currentTodoId = -1;

  int get currentTodoId => _currentTodoId;

  set currentTodoId(int todoId) {
    _currentTodoId = todoId;

    // 保存する ※awaitしない
    _save();
  }

  // -------------
  // save / load
  // -------------

  static SharedPreferences? _prefs;

  void _save() async {
    // print('[AppState] AppState._save();');

    _prefs = _prefs ?? await SharedPreferences.getInstance();

    final jsonStr = jsonEncode(
      {'currentTodoId': _currentTodoId},
    ).toString();

    // print('[AppState] jsonStr: $jsonStr');

    await _prefs!.setString(RegistryKey.appState.name, jsonStr);
  }

  Future load() async {
    // print('[AppState] AppState.load();');

    _prefs = _prefs ?? await SharedPreferences.getInstance();

    final jsonStr = _prefs!.getString(RegistryKey.appState.name);

    // print('[AppState] jsonStr: $jsonStr');

    if (jsonStr != null) {
      final jsonObj = jsonDecode(jsonStr);

      // print('[AppState] jsonObj = $jsonObj');

      _currentTodoId = jsonObj['currentTodoId'] ?? 0;
    }
  }
}
