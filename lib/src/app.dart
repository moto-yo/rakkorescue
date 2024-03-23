import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'state/settings_state.dart';

import 'widgets/page_router.dart';
import 'assets/app_images.dart';

import 'pages/game/game_page.dart';
import 'pages/note/note_page.dart';
import 'pages/how_to_play/how_to_play_page.dart';
import 'pages/settings/settings_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // print("MyApp.build()");

    // notifyListeners()が呼ばれる毎に再描画する
    return Selector<SettingsState, ThemeMode>(
      selector: (context, settingsState) => settingsState.themeMode,
      builder: (context, themeMode, child) {
        return MaterialApp(
          // restorationScopeIdを提供すると、アプリ終了からの復帰時に navigation階層が復元される
          restorationScopeId: 'app',

          // 多言語対応
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // languageCode, countryCode
            Locale('ja', ''),
          ],
          // home: 以下で取得可
          // Locale locale = Localizations.localeOf(context);
          // print(locale.languageCode); // en

          // ユーザーの localeに合った文字列を得る
          // $ flutter pub get
          //    src: /localization/app_*.arb
          //    dst: .dart_tool/flutter_gen/gen_l10n/app_localizations.dart
          onGenerateTitle: (BuildContext context) => AppLocalizations.of(context)?.appTitle ?? 'appTitle',

          // テーマを設定する
          theme: ThemeData(
              fontFamily: "Pangolin",
              fontFamilyFallback: const ["Miura", "Pangolin"],
              textTheme: const TextTheme(
                // タイトル
                titleMedium: TextStyle(
                  color: Color(0xFF5a4133),
                  fontSize: 82.0,
                ),
                // 本文
                bodyLarge: TextStyle(
                  color: Color(0xFF5a4133),
                  fontSize: 72.0,
                ),
                // 注釈
                bodyMedium: TextStyle(
                  color: Color(0xFF5a4133),
                  fontSize: 59.0,
                ),
                // 注釈
                bodySmall: TextStyle(
                  color: Color(0xFF5a4133),
                  fontSize: 16.0,
                ),
                // 文字だけボタン
                labelLarge: TextStyle(
                  color: Color(0xFF5a4133),
                  fontSize: 42.0,
                ),
                // アイコン付きボタン
                labelMedium: TextStyle(
                  color: Color(0xFF5a4133),
                  fontSize: 21.0,
                ),
              ),
              splashColor: const Color(0xffAB8458),
              navigationBarTheme: const NavigationBarThemeData(
                backgroundColor: Color(0xff504133),
                indicatorColor: Color(0xff8e6d46),
              ),
              navigationRailTheme: const NavigationRailThemeData(
                backgroundColor: Color(0xff504133),
                indicatorColor: Color(0xff8e6d46),
              )),

          // 下バー NavigationBar・横バー NavigationRail を追加する
          home: const HomePage(),
        );
      },
    );
  }
}

// 目的1: ローカライズを build()する
// 目的2: tab内のページを設定する
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageRouter(routePages: [
      RoutePage(
        const GamePage(navigatorKey: Key('tabGame')),
        const Image(image: AppImages.tabGame, height: 32),
        AppLocalizations.of(context)?.tabGame ?? 'tabGame',
      ),
      RoutePage(
        const NotePage(navigatorKey: Key('tabNote')),
        const Image(image: AppImages.tabNote, height: 32),
        AppLocalizations.of(context)?.tabNote ?? 'tabNote',
      ),
      RoutePage(
        const HowToPlayPage(navigatorKey: Key('tabHowToPlay')),
        const Image(image: AppImages.tabHowToPlay, height: 32),
        AppLocalizations.of(context)?.tabHowToPlay ?? 'tabHowToPlay',
      ),
      RoutePage(
        const SettingsPage(navigatorKey: Key('tabSetting')),
        const Image(image: AppImages.tabSetting, height: 32),
        AppLocalizations.of(context)?.tabSetting ?? 'tabSetting',
      )
    ]);
  }
}
