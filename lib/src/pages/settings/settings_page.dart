import 'package:flutter/material.dart';

import 'settings_view.dart';

// tab内のページ
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key, required this.navigatorKey});

  final Key navigatorKey;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      // deep linkと Flutter webの url用に route名をつける
      // Navigator.restorablePushNamed()で呼ばれた Widgetを開く
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            return const SettingsView();
          },
        );
      },
    );
  }
}
