import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/state/game_state.dart';
import 'src/state/settings_state.dart';
import 'src/state/app_state.dart';
import 'src/app.dart';

import 'src/assets/app_images.dart';

void main() async {
  // runApp()を実行する前に Flutterの機能を利用したい場合に呼び出す
  final binding = WidgetsFlutterBinding.ensureInitialized();

  // 画像を事前読み込みする
  binding.addPostFrameCallback((_) async {
    final BuildContext context = binding.rootElement as BuildContext;

    precacheImage(AppImages.tabGame, context);
    precacheImage(AppImages.tabNote, context);
    precacheImage(AppImages.tabHowToPlay, context);
    precacheImage(AppImages.tabSetting, context);
  });

  // ロードする ※スプラッシュ スクリーンが表示されている間にユーザーの選択したテーマを読み込み、アプリ表示後に突然テーマが変更されるのを防ぐ
  SettingsState settingsState = SettingsState();
  GameState gameState = GameState();
  AppState appState = AppState();

  await settingsState.load();
  await appState.load();

  gameState.triggerTitle();

  // Providerで配信する
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: settingsState), // 変更を通知する
        ChangeNotifierProvider.value(value: gameState),
        ChangeNotifierProvider.value(value: appState) // グローバル変数
      ],
      child: const MyApp(),
    ),
  );
}
