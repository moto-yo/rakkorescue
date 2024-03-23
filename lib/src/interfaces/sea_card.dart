// マーク
enum SeaSuit {
  heart, // 日用品のプラごみ  🧴1〜4 の 4枚, 🧴0 = ボロボート🪹
  spade, // 発泡スチロールゴミ 🧼1〜4 の 4枚, 🧼0 = ボロボート🪹
  diamond, // 漁業ごみ         🛟1〜4 の 4枚, 🛟0 = ボロボート🪹
  club, // 昆布🌿 2枚
  // ---
  rockyBeach, // らっこの岩場🪨
  empty, // 空きマス ※ゴミや昆布を取り除いた後のマス
  hidden, // 非表示マス ※盤上
  goal, // ゴール
}

// 海カード🌊
class SeaCard {
  static int _uniqueId = 1;

  final int id; // ユニークID ※削除用
  final SeaSuit suit;
  final int n; // 0〜4
  bool isOpened; // 開いている場合 true
  final bool isSurge; // 大波の場合 true

  // 実行時 tmp
  bool isSelected = false;

  SeaCard(this.suit, this.n, this.isOpened, this.isSurge) : id = _uniqueId++;

  // 自身を copyする
  SeaCard._clone(this.id, this.suit, this.n, this.isOpened, this.isSurge);
  SeaCard clone() => SeaCard._clone(id, suit, n, isOpened, isSurge);
}
