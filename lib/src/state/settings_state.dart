import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../interfaces/registry_key.dart';

// -------------
// Settings
// -------------

class SettingsState extends ChangeNotifier {
  // themeMode
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode? themeMode) {
    if ((themeMode != null) && (themeMode != _themeMode)) {
      _themeMode = themeMode;

      notifyListeners();

      // 保存する ※awaitしない
      _save();
    }
  }

  // -------------
  // save / load
  // -------------

  static SharedPreferences? _prefs;

  void _save() async {
    // print('[SettingsState] SettingsState._save();');

    _prefs = _prefs ?? await SharedPreferences.getInstance();

    final jsonStr = jsonEncode(
      {'themeMode': _themeMode.index},
    ).toString();

    // print('[SettingsState] jsonStr: $jsonStr');

    await _prefs!.setString(RegistryKey.settingsState.name, jsonStr);
  }

  Future load() async {
    // print('[SettingsState] SettingsState.load();');

    _prefs = _prefs ?? await SharedPreferences.getInstance();

    final jsonStr = _prefs!.getString(RegistryKey.settingsState.name);

    // print('[SettingsState] jsonStr: $jsonStr');

    if (jsonStr != null) {
      final jsonObj = jsonDecode(jsonStr);

      //print('[SettingsState] jsonObj = $jsonObj');

      _themeMode = ThemeMode.values[jsonObj['themeMode'] ?? 0];
    }
  }
}
