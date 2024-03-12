import 'package:flutter/material.dart';

class PlayImages {
  // SeaCard
  static const List<AssetImage> waves = [
    AssetImage('assets/play/WaveShou_ura.png'),
    AssetImage('assets/play/WaveDai_ura.png'),
  ];
  static const boroBoat = AssetImage('assets/play/oldboard_ura.png');
  static const rockyBeach = AssetImage('assets/play/rock.png');

  static const List<List<AssetImage>> seaSuits = [
    [
      AssetImage('assets/play/brokenBoard_red.png'),
      AssetImage('assets/play/red01.png'),
      AssetImage('assets/play/red02.png'),
      AssetImage('assets/play/red03.png'),
      AssetImage('assets/play/red04.png'),
    ],
    [
      AssetImage('assets/play/brokenBoard_purple.png'),
      AssetImage('assets/play/purple01.png'),
      AssetImage('assets/play/purple02.png'),
      AssetImage('assets/play/purple03.png'),
      AssetImage('assets/play/purple04.png'),
    ],
    [
      AssetImage('assets/play/brokenBoard_yellow.png'),
      AssetImage('assets/play/yellow01.png'),
      AssetImage('assets/play/yellow02.png'),
      AssetImage('assets/play/yellow03.png'),
      AssetImage('assets/play/yellow04.png'),
    ]
  ];

  static const club = AssetImage('assets/play/konbu.png');
  static const empty = AssetImage('assets/play/waveShade.png');
  static const hidden = AssetImage('assets/play/hidden.png');

  // ActionCard
  static const List<AssetImage> actionTypeHelps = [
    AssetImage('assets/play/help01.png'),
    AssetImage('assets/play/help02.png'),
    AssetImage('assets/play/help03.png'),
    AssetImage('assets/play/help04.png'),
  ];

  static const actionTypeSurfing = AssetImage('assets/play/helpRolldice.png');
  static const actionTypeResearch = AssetImage('assets/play/helpRakkoResarch.png');
  static const actionCardBack = AssetImage('assets/play/helpCard_ura.png');

  // goal
  static const goal = AssetImage('assets/play/goal.png');

  // surfboard
  static const surfboard = AssetImage('assets/play/playingPiece.png');

  // dice
  static const List<AssetImage> dices = [
    AssetImage('assets/play/dice1.png'),
    AssetImage('assets/play/dice2.png'),
    AssetImage('assets/play/dice3.png'),
    AssetImage('assets/play/dice4.png'),
    AssetImage('assets/play/dice5.png'),
    AssetImage('assets/play/dice6.png'),
  ];

  // ui
  static const tapIcon = AssetImage('assets/play/tapIcon.png');
  static const okBtn = AssetImage('assets/play/okBtn_off.png');
  static const maruBtn = AssetImage('assets/play/maruBtn_off.png');
  static const batuBtn = AssetImage('assets/play/batsuBtn_off.png');
  static const nextBtn = AssetImage('assets/play/nextBtn_off.png');
  static const skipBtn = AssetImage('assets/play/skipBtn_off.png');
  static const closeBtn = AssetImage('assets/play/closeBtn_off.png');

  // bg
  static const bg = AssetImage('assets/play/bg.png');
  static const seaDlgBg = AssetImage('assets/play/sandDlgBg.png');
  static const rollDiceBg = AssetImage('assets/play/waveDlgBg.png');
  static const happyDlgBg = AssetImage('assets/play/happyDlg.png');
  static const sameDiceDlgBg = AssetImage('assets/play/ZoromeDlgBg.png');

  static const miniDlgBg = AssetImage('assets/play/miniDlgBg.png');
  static const miniDlgBgRed = AssetImage('assets/play/Dlg_red.png'); // 赤色の miniDlg
  static const miniDlgBgGreen = AssetImage('assets/play/choice_diceDlg.png'); // 緑色の miniDlg

  static const miniLongDlgBg = AssetImage('assets/play/miniLDlg.png');
  static const miniLongDlgBgBlue = AssetImage('assets/play/choiceGoalDlgBg.png');

  static const goalBtn = AssetImage('assets/play/goalBtn_off.png');
  static const continueBtn = AssetImage('assets/play/continueBtn_off.png');

  // dialog image
  static const repairImg = AssetImage('assets/play/repairImg.png');
  static const roundMark = AssetImage('assets/play/roundMark.png');

  // らっこの岩場🪨
  static const rakkoHelp = AssetImage('assets/play/rakkoHelp.png');
  static const rakkoFace = AssetImage('assets/play/rakkoFace.png');
  static const board = AssetImage('assets/play/board.png');
  static const brokenBoard = AssetImage('assets/play/brokenBoard_gomitori.png');
}
