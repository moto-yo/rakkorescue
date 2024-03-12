import 'package:flutter/material.dart';

import 'play_info_view.dart';
import 'rocky_beach_view.dart';
import 'sea_card_layout.dart';
import 'sea_dlg.dart';
import 'sea_mini_dlg.dart';
import 'sea_mini_long_dlg.dart';
import 'play_action_cards_view.dart';
import 'surfboard_view.dart';

// 画面サイズ変更時のレイアウト計算
class PlayLayout extends StatelessWidget {
  const PlayLayout({super.key});

  static const List<int> _seaCardIs = [
    4, 5, 6, 7, 8, // 1
    3, 16, 18, 20, 9, // 2
    2, 17, 19, 21, 10, // 3
    1, 22, 23, 24, 11, // 4
    0, 15, 14, 13, 12, // 5
    -1, 25, 26, 27, 28, // 6
  ];
  static const Offset _space = Offset(1.0, 5.0);
  static const Size _seaCardSize = Size(376, 415);
  static final double _aspectRatio = _seaCardSize.width / _seaCardSize.height; // width / height

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      double constraintsWidth = constraints.maxWidth - _space.dx * 2.0;
      double constraintsHeight = constraints.maxHeight - _space.dy * 2.0 - PlayInfoView.height;

      // constraintsWidth  ≦ gridWidth  * 5 + _space.dx * 4
      // constraintsHeight ≦ gridHeight * 6 + _space.dy * 5
      // gridWidth / gridHeight = _aspectRatio

      double gridWidth = (constraintsWidth - _space.dx * 4) / 5;
      double gridHeight = (constraintsHeight - _space.dy * 5) / 6;

      if (gridWidth < gridHeight * _aspectRatio) {
        // 縦長の場合
        gridHeight = gridWidth / _aspectRatio;
        constraintsHeight = gridHeight * 6 + _space.dy * 5;
      } else {
        // 横長の場合
        gridWidth = gridHeight * _aspectRatio;
        constraintsWidth = gridWidth * 5 + _space.dx * 4;
      }

      return Column(children: [
        // info
        const PlayInfoView(),
        const Spacer(),
        // 盤面・盤上の🌊海 grid
        Center(
          child: SizedBox(
            width: constraintsWidth,
            height: constraintsHeight,
            child: Stack(children: [
              RockyBeachView(
                gridWidth: gridWidth,
                gridHeight: gridHeight,
                space: _space,
              ),
              GridView.count(
                shrinkWrap: true, // 子要素の高さの合計 ≦ GridViewの高さ
                physics: const NeverScrollableScrollPhysics(), // スクロールを無効にする
                childAspectRatio: gridWidth / gridHeight,
                crossAxisCount: 5,
                crossAxisSpacing: _space.dx,
                mainAxisSpacing: _space.dy,
                children: _seaCardIs
                    .map((seaCardI) => SeaCardLayout(
                          index: seaCardI,
                        ))
                    .toList(),
              ),
              SurfboardView(
                gridWidth: gridWidth,
                gridHeight: gridHeight,
                space: _space,
              ),
              // アクション カード
              PlayActionCardsView(
                gridWidth: gridWidth,
                gridHeight: gridHeight,
                space: _space,
              ),
              SeaDlg(
                gridWidth: gridWidth,
                gridHeight: gridHeight,
                space: _space,
              ),
              SeaMiniDlg(
                gridWidth: gridWidth,
                gridHeight: gridHeight,
                space: _space,
              ),
              SeaMiniLongDlg(
                gridWidth: gridWidth,
                gridHeight: gridHeight,
                space: _space,
              ),
            ]),
          ),
        ),
        const Spacer(),
      ]);
    });
  }
}
