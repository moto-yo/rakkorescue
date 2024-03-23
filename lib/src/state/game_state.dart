import 'dart:core';
import 'dart:math' as math;
import 'dart:async';

import 'package:flutter/material.dart';

import '../interfaces/state_type.dart';
import '../interfaces/sea_card.dart';
import '../interfaces/action_card.dart';
import '../interfaces/role_card.dart';

// -------------
// Game
// -------------

class GameState extends ChangeNotifier {
  static final _random = math.Random();

  // 現在の状態
  StateType _stateTypeProc = StateType.title;
  StateType get stateType => _stateTypeProc;
  set _stateType(StateType stateType) {
    _stateTypeProc = stateType;

    print("stateType = $_stateTypeProc");

    // 再描画する
    notifyListeners();
  }

  // 海カード
  final List<SeaCard> _seaCards = []; // 盤面の海カード 15枚
  final List<SeaCard> _seaDeckCards = []; // 海デッキに残っている海カード
  int _seaDeckI = 0; // 海デッキの周回数, 偶数=小波, 奇数=大波

  final List<SeaSuit> _seaSuits = [SeaSuit.heart, SeaSuit.spade, SeaSuit.diamond];

  // 海カードのデッキから海カードを引く
  SeaCard _drawSeaCard() {
    // カードが無い場合
    if (_seaDeckCards.isEmpty) {
      // デッキを用意する

      final bool isSurge = (_seaDeckI % 2) == 1; // 大波の場合 true

      // 日用品のプラごみ🧴 1〜4 の 4枚
      for (int i = 1; i <= 4; i++) {
        _seaDeckCards.add(SeaCard(SeaSuit.heart, i, false, isSurge));
      }

      // 発泡スチロールゴミ🧼 1〜4 の 4枚
      for (int i = 1; i <= 4; i++) {
        _seaDeckCards.add(SeaCard(SeaSuit.spade, i, false, isSurge));
      }

      // 漁業ごみ🛟 1〜4 の 4枚
      for (int i = 1; i <= 4; i++) {
        _seaDeckCards.add(SeaCard(SeaSuit.diamond, i, false, isSurge));
      }

      // 昆布🌿 大波 1枚, 小波 2枚
      for (int i = 0, n = isSurge ? 1 : 2; i < n; i++) {
        _seaDeckCards.add(SeaCard(SeaSuit.club, 0, false, isSurge));
      }

      // 大波 ランダムゴミ 1枚
      if (isSurge) {
        final int suitI = _random.nextInt(3); // 0 ≦ rnd ≦ 2
        final int seaN = 1 + _random.nextInt(4); // 1 ≦ rnd ≦ 4

        _seaDeckCards.add(SeaCard(_seaSuits[suitI], seaN, false, isSurge));
      }

      // デッキをシャッフルする
      _seaDeckCards.shuffle();

      // next
      _seaDeckI++;
    }

    // デッキからカードを引く
    return _seaDeckCards.removeLast();
  }

  static final seaCardEmpty = SeaCard(SeaSuit.empty, 0, true, false); // ID=0固定

  // 🌊盤面の海カードを得る, 16枚, らっこの岩場🪨を含む
  SeaCard getSeaCardIndex(int index) {
    if (!((0 <= index) && (index < _seaCards.length + ((11 <= index) ? 1 : 0)))) {
      return seaCardEmpty;
    }

    int i = index % 16;

    // らっこの岩場🪨
    if (i == 11) {
      return SeaCard(SeaSuit.rockyBeach, _waitingRakkoN, true, false); // ID=0固定
    }

    // 🌊海カード
    if (11 <= i) {
      i--;
    }

    return _seaCards[i];
  }

  // 🪑盤上の海カード
  final List<SeaCard> tableCards = [];

  // 🌊海カードを得る, 盤上のゴミカードも含む
  SeaCard getSeaCardId(int id) {
    // 🌊盤面の海カード
    {
      final seaCard = _seaCards.firstWhere((seaCard) => seaCard.id == id, orElse: () => seaCardEmpty);

      if (seaCard != seaCardEmpty) {
        return seaCard;
      }
    }

    // 🪑盤上の海カード
    {
      final seaCard = tableCards.firstWhere((seaCard) => seaCard.id == id, orElse: () => seaCardEmpty);

      if (seaCard != seaCardEmpty) {
        return seaCard;
      }
    }

    return seaCardEmpty;
  }

  // アクション カード
  final List<ActionCard> actionCards = []; // 所持しているアクション カード
  final List<ActionCard> _actionDeckCards = []; // アクション カードのデッキ

  // アクション カードのデッキからアクション カードを引く
  ActionCard _drawActionCard() {
    // カードが無い場合
    if (_actionDeckCards.isEmpty) {
      // デッキを用意する

      // らっこの手助け💪 1x3枚, 2x3枚, 3x3枚, 4x3枚
      for (int i = 0; i < 3; i++) {
        for (int j = 1; j <= 4; j++) {
          _actionDeckCards.add(ActionCard(ActionType.help, j));
        }
      }

      // 波乗りアゲイン🏄‍♂️ 2枚
      for (int i = 0; i < 2; i++) {
        _actionDeckCards.add(const ActionCard(ActionType.surfing, 0));
      }

      // らっこリサーチ👀 2枚
      for (int i = 0; i < 2; i++) {
        _actionDeckCards.add(const ActionCard(ActionType.research, 0));
      }

      // デッキをシャッフルする
      _actionDeckCards.shuffle();
    }

    // デッキからカードを引く
    return _actionDeckCards.removeLast();
  }

  // らっこの手助け💪で取り除けるゴミ
  final List<RoleCard> debriCards = [];

  void _canRemoveDebriCards() {
    // 返り値
    debriCards.clear();

    // 🌊海カード
    for (final seaCard in _seaCards) {
      if (seaCard.isOpened && (seaCard.suit.index <= 3)) {
        debriCards.add(RoleCard(false, seaCard.id));
      }
    }

    // 🪑盤上の海カード
    for (final seaCard in tableCards) {
      debriCards.add(RoleCard(true, seaCard.id));
    }
  }

  // 作れる役
  final List<Role> roles = [];

  // 作れる役を列挙する
  void listRoles() {
    print('listRoles()');

    // 判定用 行列を生成する
    final List<List<RoleCard>> matrix = []; // [数字 1-4][マーク 0-2]

    for (int col = 0; col < 3; col++) {
      // 縦 マーク 0-2
      for (int row = 0; row < 4; row++) {
        // 横 数字 1-4
        // const int i = row + col * 4;

        matrix.add([]);
      }
    }

    {
      // テーブルの要素を代入する
      for (final seaCard in tableCards) {
        final int row = seaCard.n - 1;

        if (0 <= row) {
          final int i = row + seaCard.suit.index * 4;

          matrix[i].add(RoleCard(true, seaCard.id));
        }
      }

      // 🌊海カードの要素を代入する
      for (final seaCard in _seaCards) {
        final int row = seaCard.n - 1;

        if (seaCard.isOpened && (seaCard.suit.index < 3) && (0 <= row)) {
          final int i = row + seaCard.suit.index * 4;

          matrix[i].add(RoleCard(false, seaCard.id));
        }
      }
    }

    // 返り値
    roles.clear();

    // ストレート フラッシュ: 同じマークで連なる数字が 3枚 ❤️1 ❤️2 ❤️3
    for (int suit = 0; suit < 3; suit++) {
      // 2, 3, 4
      for (int d = 0; d < 2; d++) {
        final List<List<RoleCard>> cards = []; // 1枚目の配列, 2枚目の配列, 3枚目の配列

        for (int i = 0; i < 3; i++) {
          cards.add([]);
        }

        // 1, 2, 3
        for (int i = 0; i < 3; i++) {
          final int offset = (i + d) + suit * 4;
          final int n = matrix[offset].length;

          for (int j = 0; j < n; j++) {
            final RoleCard roleCard = matrix[offset][j];

            cards[i].add(roleCard);
          }
        }

        // 全組み合わせ
        for (final seaCard0 in cards[0]) {
          for (final seaCard1 in cards[1]) {
            for (final seaCard2 in cards[2]) {
              roles.add(Role([seaCard0, seaCard1, seaCard2], true));
            }
          }
        }
      }
    }

    // スリーカード: 同じ数字で異なるマークが 3枚 ❤️1 ♠️1 ♦︎1
    for (int i = 0; i < 4; i++) {
      // [1-4]
      final List<List<RoleCard>> cards = []; // [❤️n, ♠️n, ♦︎n]

      for (int j = 0; j < 3; j++) {
        cards.add([]);
      }

      for (int suit = 0; suit < 3; suit++) {
        final int offset = i + suit * 4;
        final int n = matrix[offset].length;

        for (int j = 0; j < n; j++) {
          final RoleCard roleCard = matrix[offset][j];

          cards[suit].add(roleCard);
        }
      }

      // 全組み合わせ
      for (final seaCard0 in cards[0]) {
        for (final seaCard1 in cards[1]) {
          for (final seaCard2 in cards[2]) {
            roles.add(Role([seaCard0, seaCard1, seaCard2], false));
          }
        }
      }
    }
  }

  // 新しい海カードを補充する
  void _refresh() {
    // 開いている🌊海カードを削除する
    for (int i = 0; i < _seaCards.length;) {
      final SeaCard seaCard = _seaCards[i];

      if ((seaCard.isOpened && seaCard.suit.index < 3) || // 開いているゴミ ※開いているボロボート🪹を含む
          ((seaCard.suit.index < 3) && (seaCard.n == 0)) || // ボロボート🪹
          (seaCard.suit == SeaSuit.empty)) // 空きマス
      {
        // 開いているゴミを場へ移動する
        if (seaCard.isOpened && (seaCard.suit.index < 3)) {
          tableCards.add(seaCard);
        }

        // 盤面の🌊海カードを削除する
        _seaCards.removeAt(i);

        continue;
      }

      // next
      i++;
    }

    // 開いている 2枚目以降の昆布カード🌿を削除する
    {
      bool isFirstClub = true;

      for (int i = 0; i < _seaCards.length;) {
        SeaCard seaCard = _seaCards[i];

        if (seaCard.isOpened && (seaCard.suit == SeaSuit.club)) {
          if (isFirstClub) {
            isFirstClub = false;
          } else {
            _seaCards.removeAt(i);

            continue;
          }
        }

        // next
        i++;
      }
    }

    // 14枚になるまで海デッキからカードを引いて追加する
    while (_seaCards.length < 14) {
      final SeaCard seaCard = _drawSeaCard();

      print('seaCard = {id: ${seaCard.id}, suit: ${seaCard.suit}, n: ${seaCard.n}, isOpened: ${seaCard.isOpened}, isSurge: ${seaCard.isSurge}');

      _seaCards.insert(0, seaCard);
    }

    // 閉じているボロボート🪹を追加する
    {
      final int suitI = _random.nextInt(3); // 0 ≦ rnd ≦ 2

      _seaCards.insert(4, SeaCard(_seaSuits[suitI], 0, false, false));
    }
  }

  // 同じマークが 3つ揃った場合 true
  bool isGameOver() {
    final List<int> suitNs = [0, 0, 0];

    for (final seaCard in _seaCards) {
      if (seaCard.isOpened) {
        if (seaCard.suit.index < 3) {
          suitNs[seaCard.suit.index] += 1;
        }
      }
    }

    for (final seaCard in tableCards) {
      if (seaCard.suit.index < 3) {
        suitNs[seaCard.suit.index] += 1;
      }
    }

    for (final suitN in suitNs) {
      if (3 <= suitN) {
        return true;
      }
    }

    return false;
  }

  // 壊れたボート🛶を修理⛵️できる場合 true
  bool canRepaireBoat() {
    // 壊れたボート🛶を持っている場合
    if (0 < _brokenBoatN) {
      // 開いた昆布カードを持っている場合
      for (final seaCard in _seaCards) {
        if (seaCard.isOpened && (seaCard.suit == SeaSuit.club)) {
          return true;
        }
      }
    }

    return false;
  }

  // 波乗りサイコロ🎲🎲
  final List<int> _dice = [0, 0];

  int dice(int i) {
    return _dice[i];
  }

  // 選択したアクション カード
  int _choicedActionCardI = -1;

  int get choicedActionCardI => _choicedActionCardI;

  // 岩場の救助待ちのらっこの数
  int _waitingRakkoN = 0;

  int get waitingRakkoN => _waitingRakkoN;

  // ボートに乗せたらっこの数
  int _helpedRakkoN = 0;

  int get helpedRakkoN => _helpedRakkoN;

  // サーフボード🏄の位置
  int _surfboardI = -1;

  int get surfboardI => _surfboardI;

  // ダイスの残り移動量
  int _moveN = 0;

  int get moveN => _moveN;

  // 壊れたボード🛶の数
  int _brokenBoatN = 0;

  int get brokenBoatN => _brokenBoatN;

  // 修理したボード⛵️の数
  int _repairedBoatN = 0;

  int get repairedBoatN => _repairedBoatN;

  // 周回数
  int _roundI = 0;

  int get roundI => _roundI;

  // 取り除いた🗑️ごみカードの枚数
  final _debriCardCounts = List<int>.filled(5 * 3, 0); // [数字 0-4][マーク 0-2]

  int debriCardCounts(SeaSuit suit, int n) {
    return _debriCardCounts[n + suit.index * 5];
  }

  // 使用したアクション カードの記録
  final List<ActionCard> _logActionCards = [];

  int get logActionCardN => _logActionCards.length;

  ActionCard logActionCard(int i) {
    return _logActionCards[i];
  }

  // らっこの手助けでゴミ取りした記録
  final List<SeaCard> _logRemoveDebris = [];

  int get logRemoveDebriN => _logRemoveDebris.length;

  SeaCard logRemoveDebri(int i) {
    return _logRemoveDebris[i];
  }

  // 役でゴミ取りした記録
  final List<List<SeaCard>> _logRemoveDebriSets = []; // [3][]

  int get logRemoveDebriSetN => _logRemoveDebriSets.length;

  List<SeaCard> logRemoveDebriSet(int i) {
    return _logRemoveDebriSets[i];
  }

  // ゴミ取りする役の index
  int _removeDebriRoleI = 0;
  int get removeDebriRoleI => _removeDebriRoleI;
  set removeDebriRoleI(int i) {
    _removeDebriRoleI = i;

    print("removeDebriRoleI = $_removeDebriRoleI");

    // 再描画する
    notifyListeners();
  }

  // ---------------------------
  // 状態を遷移する
  // ---------------------------

  void triggerTitle() {
    // 状態を更新する
    _stateType = StateType.title;

    // 遷移する
    // triggerStart();
  }

  void triggerStart() {
    // 初期化する
    {
      // アクション カード
      actionCards.clear();
      _actionDeckCards.clear();

      // 海カード
      _seaCards.clear();
      _seaDeckCards.clear();

      _seaDeckI = 0;

      // 🪑盤上の海カード
      tableCards.clear();

      // 作れる役
      roles.clear();

      // 波乗りサイコロ🎲🎲
      _dice[0] = 0;
      _dice[1] = 0;

      // 選択したアクション カード
      _choicedActionCardI = -1;

      // 岩場の救助待ちのらっこの数
      _waitingRakkoN = 0;

      // ボートに乗せたらっこの数
      _helpedRakkoN = 0;

      // サーフボード🏄の位置
      _surfboardI = -1;

      // ダイスの残り移動量
      _moveN = 0;

      // 壊れたボード🛶の数
      _brokenBoatN = 0;

      // 修理したボード⛵️の数
      _repairedBoatN = 0;

      // 周回数
      _roundI = 0;

      // 取り除いた🗑️ごみカードの枚数
      for (int i = 0; i < _debriCardCounts.length; i++) {
        _debriCardCounts[i] = 0;
      }

      // 使用したアクション カードの記録
      _logActionCards.clear();

      // らっこの手助けでゴミ取りした記録
      _logRemoveDebris.clear();

      // 役でゴミ取りした記録
      _logRemoveDebriSets.clear();
    }

    // 状態を更新する
    _stateType = StateType.start;

    // 遷移する
    triggerRound();
  }

  // アクション カードを引く

  void triggerDrawActionCard() {
    // なにがでるかな？

    // 状態を更新する
    _stateType = StateType.drawActionCard;

    // 遷移する
    // triggerNext();
  }

  void triggerDrawedActionCard() {
    // 「ゴミとり」Get!

    // アクション カードを 1枚引く
    actionCards.add(_drawActionCard());

    // 引いたカードを表示する

    // 状態を更新する
    _stateType = StateType.drawedActionCard;

    // 遷移する
    // triggerLimitActionCard();  // アクション カードを 1枚選んで捨てる 3 <= actionCards.length
    // triggerRollDice();         // ラウンド開始 roundI = 1
    // triggerMoveForward();      // ラウンド継続 1 < roundI
  }

  void triggerLimitActionCard() {
    // らっこの助けは 2つまで！ 捨てるものを 1つ選んでください

    // 状態を更新する
    _stateType = StateType.limitActionCard;

    // 遷移する
    // triggerChoiceIndex(int index);
  }

  void triggerLimitActionCardAnim(int index) {
    // 選択されたアクション カードを削除する
    actionCards.removeAt(index);

    // 状態を更新する
    _stateType = StateType.limitActionCardAnim;

    // 遷移する
    if (_roundI == 1) {
      // ラウンド開始
      triggerRollDice();
    } else {
      // ラウンド継続
      triggerMoveForward();
    }
  }

  // さぁ行こう！🎲🎲

  void triggerRollDice() {
    _dice[0] = 1 + _random.nextInt(6); // 1 ≦ rnd ≦ 6
    _dice[1] = 1 + _random.nextInt(6); // 1 ≦ rnd ≦ 6

    // 状態を更新する
    _stateType = StateType.rollDice;

    // 遷移する
    // triggerNext();
  }

  void triggerDiceRolled() {
    // 状態を更新する
    _stateType = StateType.diceRolled;

    // サイコロ🎲🎲の出目を表示する

    // 遷移する
    if (_dice[0] == _dice[1]) {
      // ゾロ目の場合
      triggerDiceSame();
    } else {
      // ゾロ目でない場合
      triggerDiceDifferent();
    }
  }

  void triggerDiceSame() {
    // らっこが岩場に1匹増える
    _waitingRakkoN++;

    // 状態を更新する
    _stateType = StateType.diceSame;

    // 遷移する
    // triggerRollDice();
  }

  void triggerDiceDifferent() {
    // 状態を更新する
    _stateType = StateType.diceDifferent;

    // サイコロの出目で移動できる位置を表示する

    // 遷移する
    if (actionCards.isNotEmpty) {
      // アクション カードがある場合
      triggerChoiceActionCard();
    } else {
      // アクション カードが無い場合
      triggerActioned();
    }
  }

  // アクション カードの選択

  void triggerChoiceActionCard() {
    _choicedActionCardI = -1;

    // らっこの手助けで取り除けるカードを cacheする
    _canRemoveDebriCards();

    // 状態を更新する
    _stateType = StateType.choiceActionCard;

    // 遷移する

    // skip
    {
      // 使えるアクション カードが無い場合、アクション カードの選択をスキップする
      bool isSkip = true;

      for (final actionCard in actionCards) {
        if (actionCard.canUse(this)) {
          isSkip = false;

          break;
        }
      }

      if (isSkip) {
        // skip
        triggerActioned();
      }
    }

    // triggerRakosHelp(int actionCardI);         // らっこの手助け💪 海上か盤上のゴミを 1つ取り除く
    // triggerSurfingAgainAnim(int actionCardI);  // 波乗りアゲイン🏄‍♂️ サイコロを振り直す
    // triggerRakosResearch(int actionCardI);     // らっこリサーチ👀 海上の伏せカードを 1枚覗き見する
  }

  // らっこの手助け💪

  void triggerRakosHelp(int actionCardI) {
    _choicedActionCardI = actionCardI;

    // 状態を更新する
    _stateType = StateType.rakosHelp;

    // 遷移する
    // triggerChoiceId(int id);   // 取り除くゴミ
    // triggerChoiceActionCard(); // アクション カードの選択に戻る
  }

  // アクション カードを消費する
  void consumeChoicedActionCard() {
    // 使用したアクション カードを記録する
    _logActionCards.add(actionCards[_choicedActionCardI]);

    // アクション カードを削除する
    actionCards.removeAt(_choicedActionCardI);

    _choicedActionCardI = -1;
  }

  bool onRakosHelpAnimProc(SeaCard seaCard) {
    // ボロボート🪹の場合
    bool isBrokenBoat = false; // ボロボートの場合 true

    if (seaCard.n == 0) {
      isBrokenBoat = true;

      // 壊れたボード🛶の数を増やす
      _brokenBoatN++;
    }

    // 取り除いた🗑️ごみカードの枚数
    {
      final int i = seaCard.n + seaCard.suit.index * 5;

      _debriCardCounts[i] += 1;
    }

    // らっこの手助けでしたゴミ取りを記録する
    _logRemoveDebris.add(seaCard);

    return isBrokenBoat;
  }

  void triggerRakosHelpAnim(int seaCardId) {
    // ゴミを取り除くアニメーションを再生する

    // 🌊海カードを取り除く
    bool isBrokenBoat = false; // ボロボートの場合 true

    {
      // 🌊盤面の海カードの場合
      {
        final foundI = _seaCards.indexWhere((seaCard) => seaCard.id == seaCardId);

        if (0 <= foundI) {
          isBrokenBoat = onRakosHelpAnimProc(_seaCards[foundI]);

          // 空きマスにする
          _seaCards[foundI] = seaCardEmpty;
        }
      }

      // 盤上の🌊海カードの場合
      {
        final foundI = tableCards.indexWhere((seaCard) => seaCard.id == seaCardId);

        if (0 <= foundI) {
          isBrokenBoat = onRakosHelpAnimProc(tableCards[foundI]);

          // 削除する
          tableCards.removeAt(foundI);
        }
      }
    }

    // アクション カードを消費する
    consumeChoicedActionCard();

    // 状態を更新する
    _stateType = StateType.rakosHelpAnim;

    // ボロボート以外の場合
    if (!isBrokenBoat) {
      // 遷移する
      if (actionCards.isNotEmpty) {
        // アクション カードがある場合
        triggerChoiceActionCard();
      } else {
        // アクション カードが無い場合
        triggerActioned();
      }
    }

    // ボロボートの場合、ダイアログを表示する
  }

  // 波乗りアゲイン🏄‍♂️

  void triggerSurfingAgainAnim(int actionCardI) {
    _choicedActionCardI = actionCardI;

    // 波乗りアゲインのアニメーションを再生する

    // アクション カードを消費する
    consumeChoicedActionCard();

    // 状態を更新する
    _stateType = StateType.surfingAgainAnim;

    // 遷移する
    triggerRollDice();
  }

  // らっこリサーチ👀

  // らっこリサーチで調べる🌊海カードを選ぶ
  void triggerRakosResearch(int actionCardI) {
    _choicedActionCardI = actionCardI;

    // 調べる🌊海カードを選択し、useState()か Contextで保持する

    // 状態を更新する
    _stateType = StateType.rakosResearch;

    // 遷移する
    // triggerNext();
    // triggerChoiceActionCard(); // アクション カードの選択に戻る
  }

  int _researchedSeaCardId = -1;
  int get researchedSeaCardId => _researchedSeaCardId;

  // らっこリサーチで選んだカードを開示する
  void triggerRakosResearchAnim(int seaCardId) {
    _researchedSeaCardId = seaCardId;

    // アクション カードを消費する
    consumeChoicedActionCard();

    // 状態を更新する
    _stateType = StateType.rakosResearchAnim;

    // 遷移する
    // triggerChoiceActionCard(); // アクション カードがある場合
    // triggerActioned();         // アクション カードが無い場合
  }

  void triggerActioned() {
    // 状態を更新する
    _stateType = StateType.actioned;

    // 遷移する
    if (16 <= _surfboardI + math.max(_dice[0], _dice[1])) {
      // ゴールできる場合
      triggerChoiceGoal();
    } else {
      // ゴールできない場合
      triggerChoiceDice();
    }
  }

  // ゴールする! 続けて波乗り

  void triggerChoiceGoal() {
    // 状態を更新する
    _stateType = StateType.choiceGoal;

    // 遷移する
    // triggerSuccess();    // らっこを助けられた
    // triggerMiss();       // らっこを助けられなかった
    // triggerChoiceDice(); // 波乗り継続
  }

  void triggerSuccess() {
    // 状態を更新する
    _stateType = StateType.success;

    // 遷移する
    // triggerNext();
  }

  void triggerSuccessAnim() {
    // 状態を更新する
    _stateType = StateType.successAnim;

    // 遷移する
    // triggerTitle();  // 新しいらっこを発見しなかった場合
    // triggerNext();   // 新しいらっこを発見した場合
  }

  void triggerDiscoverRakko() {
    // 新しいラッコを発見する

    // 状態を更新する
    _stateType = StateType.discoverRakko;

    // 遷移する
    // triggerTitle();
  }

  void triggerMiss() {
    // 状態を更新する
    _stateType = StateType.miss;

    // 遷移する
    triggerMissAnim();
  }

  void triggerMissAnim() {
    // 状態を更新する
    _stateType = StateType.missAnim;

    // 遷移する
    // triggerTitle();
  }

  // どちらの波に乗りますか?

  void triggerChoiceDice() {
    // 進むサイコロを選択する

    // 状態を更新する
    _stateType = StateType.choiceDice;

    // 遷移する
    // triggerChoiceIndex(int index);
  }

  void triggerDiceChoiced(int diceI) {
    // 進むサイコロを選択した

    // 移動量を設定する
    _moveN = _dice[diceI];

    // 状態を更新する
    _stateType = StateType.diceChoiced;

    // 遷移する
    if (16 <= _surfboardI + _moveN) {
      // 1周する場合
      triggerRound();
    } else {
      // 1周していない場合
      triggerMoveForward();
    }
  }

  void triggerRound() {
    // ラウンド開始
    // ラウンド継続

    // 周回数を増やす
    _roundI++;

    // らっこが岩場に1匹増える
    _waitingRakkoN++;

    // 新しい海カードを補充する
    _refresh();

    // 状態を更新する
    _stateType = StateType.round;

    // 遷移する
    // triggerNext();
  }

  void triggerMoveForward() {
    // 1歩前へ移動する
    _surfboardI = (_surfboardI + 1) % 16;
    _moveN--;

    // 状態を更新する
    _stateType = StateType.moveForward;

    // 遷移する

    // アニメーションで 1歩ずつ前へ移動する
    Timer.periodic(const Duration(milliseconds: 162), (timer) {
      // 移動量が 0になった場合
      if (_moveN <= 0) {
        final seaCard = getSeaCardIndex(_surfboardI);

        if (seaCard.suit == SeaSuit.rockyBeach) {
          // らっこの岩場🪨に到達した場合

          if (_helpedRakkoN < 5 + _repairedBoatN * 4) {
            // 岩場🪨のらっこを救出する
            triggerHelpRakko();
          } else {
            // 満員ダイアログを表示する
            triggerCannotHelpRakko();
          }
        } else {
          // 🌊海カードに到達した場合
          triggerOpenSeaCard(seaCard.id, _surfboardI == 4);
        }

        timer.cancel();
      } else {
        // 移動量が残っている場合、1歩前に進む
        triggerMoveForward();
      }
    });
  }

  void triggerHelpRakko() {
    // 岩場🪨のらっこを救出する
    // サーフボード🏄 5匹 + 修理したボード⛵️ 4匹
    int newHelpedRakkoN = math.min(_helpedRakkoN + _waitingRakkoN, 5 + _repairedBoatN * 4);

    _waitingRakkoN -= (newHelpedRakkoN - _helpedRakkoN);
    _helpedRakkoN = newHelpedRakkoN;

    // 状態を更新する
    _stateType = StateType.helpRakko;

    // 遷移する
    // triggerRollDice();         // waitingRakkoN = 0 の場合、サイコロを振る に戻る
    // triggerCannotHelpRakko();  // 0 < waitingRakkoN の場合、満員ダイアログを表示する
  }

  void triggerCannotHelpRakko() {
    // 満員ダイアログを表示する

    // 状態を更新する
    _stateType = StateType.cannotHelpRakko;

    // 遷移する
    // triggerRollDice();
  }

  int _openSeaCardId = -1;
  int get openSeaCardId => _openSeaCardId;

  bool _openSeaCardIsBoroBoat = false;
  bool get openSeaCardIsBoroBoat => _openSeaCardIsBoroBoat;

  void triggerOpenSeaCard(int id, bool isBoroBoat) {
    _openSeaCardId = id;
    _openSeaCardIsBoroBoat = isBoroBoat;

    // 🌊海カードを開くアニメーションを再生する

    // 状態を更新する
    _stateType = StateType.openSeaCard;
  }

  void triggerOpenedSeaCard() {
    // 作れる役を列挙する
    listRoles();

    // 状態を更新する
    _stateType = StateType.openedSeaCard;

    // 🌊海カードを開くアニメーションを再生する

    // 役でゴミを取り除ける場合
    if (roles.isNotEmpty) {
      // 役でゴミを取り除く
      triggerRemoveDebri();
    } else {
      // 同じマークが 3つ揃った場合
      if (isGameOver()) {
        // GAME OVER
        triggerGameOver();
      } else {
        if (canRepaireBoat()) {
          // 壊れたボート🛶を修理⛵️できる場合
          triggerChoiceRepairBoat();
        } else {
          // 壊れたボート🛶を修理⛵️できない場合
          triggerRollDice();
        }
      }
    }
  }

  void triggerRemoveDebri() {
    // どの役でゴミ取りするかを選択する

    // 状態を更新する
    _stateType = StateType.removeDebri;

    // 遷移する
    // triggerRollDice();             // ターン終了する場合
    // triggerChoiceIndex(int index); // 役でゴミを取り除く, roles[index]
  }

  void removeDebriCardProc(SeaCard seaCard) {
    // ボロボート🪹を削除する場合
    if (seaCard.n == 0) {
      // 壊れたボード🛶の数を増やす
      _brokenBoatN++;
    }

    // 取り除いた🗑️ごみカードの枚数
    {
      final int i = seaCard.n + seaCard.suit.index * 5;

      _debriCardCounts[i] += 1;
    }
  }

  void triggerRemoveDebriAnim(int index) {
    // ゴミとりアニメーション

    // 選択した役を得る
    final Role role = roles[index];

    // 役のカードを取り除く
    List<SeaCard> logRemoveDebriSet = [seaCardEmpty, seaCardEmpty, seaCardEmpty];
    int logRemoveDebriI = 0;

    for (final roleCard in role.cards) {
      if (roleCard.isTableCard) {
        // 盤上
        for (int i = 0; i < tableCards.length;) {
          final seaCard = tableCards[i];

          if (seaCard.id == roleCard.id) {
            removeDebriCardProc(seaCard);

            // 役でゴミ取りした記録
            logRemoveDebriSet[logRemoveDebriI++] = seaCard;

            // 削除する
            tableCards.removeAt(i);

            // idはユニーク
            // continue;
            break;
          }

          // next
          i++;
        }
      } else {
        // 盤面
        for (int i = 0; i < _seaCards.length; i++) {
          final seaCard = _seaCards[i];

          if (seaCard.id == roleCard.id) {
            removeDebriCardProc(seaCard);

            // 役でゴミ取りした記録
            logRemoveDebriSet[logRemoveDebriI++] = seaCard;

            // 空きマスにする
            _seaCards[i] = seaCardEmpty;

            // idはユニーク ※削除してない
            break;
          }
        }
      }
    }

    _logRemoveDebriSets.add(logRemoveDebriSet);

    // 状態を更新する
    _stateType = StateType.removeDebriAnim;

    // 遷移する
    if (canRepaireBoat()) {
      // 壊れたボート🛶を修理⛵️できる場合
      triggerChoiceRepairBoat();
    } else {
      // 壊れたボート🛶を修理⛵️できない場合
      triggerRollDice();
    }
  }

  void triggerGameOver() {
    // 状態を更新する
    _stateType = StateType.gameOver;

    // 遷移する
    // triggerMiss();
  }

  // 昆布でボートを修理する?

  void triggerChoiceRepairBoat() {
    // 昆布でボートを修理する？ Yes/No

    // 状態を更新する
    _stateType = StateType.choiceRepairBoat;

    // 遷移する
    // triggerNext();     // 壊れたボート🛶を修理⛵️する場合
    // triggerRollDice(); // 壊れたボート🛶を修理⛵️しない場合
  }

  void triggerRepairBoat() {
    // 使用する昆布カードを選択する

    // 状態を更新する
    _stateType = StateType.repairBoat;

    // 遷移する
    // triggerChoiceId(int id);
  }

  void triggerRepairBoatAnim(int id) {
    // 修理アニメーション

    // 盤面の🌿昆布カードを取り除く
    {
      final foundI = _seaCards.indexWhere((seaCard) => seaCard.id == id);

      if (0 <= foundI) {
        // 空きマスにする, isTableCard=false
        _seaCards[foundI] = seaCardEmpty;

        // 壊れたボード🛶の数を減らす
        _brokenBoatN--;

        // 修理したボード⛵️の数を増やす
        _repairedBoatN++;
      }
    }

    // 状態を更新する
    _stateType = StateType.repairBoatAnim;

    // 遷移する
    // triggerRollDice();
  }
}
