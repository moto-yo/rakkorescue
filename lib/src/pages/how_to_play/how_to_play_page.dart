import 'package:flutter/material.dart';

import 'how_to_play_view.dart';

// tab内のページ
class HowToPlayPage extends StatelessWidget {
  const HowToPlayPage({super.key, required this.navigatorKey});

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
            return const HowToPlayView();
          },
        );
      },
    );
  }
}
