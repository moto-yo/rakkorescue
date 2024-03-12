import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../interfaces/state_type.dart';
import '../../state/game_state.dart';

import 'title_view.dart';
import 'play_view.dart';

// tab内のページ
class GamePage extends StatelessWidget {
  const GamePage({super.key, required this.navigatorKey});

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
            return Consumer<GameState>(
              builder: (context, gameState, _) {
                switch (gameState.stateType) {
                  case StateType.title:
                    return const TitleView();
                  default:
                    return const PlayView();
                }
              },
            );
          },
        );
      },
    );
  }
}
