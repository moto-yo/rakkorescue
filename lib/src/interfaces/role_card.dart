// 役カードの index
class RoleCard {
  final bool isTableCard; // true = tableCards, false = _seaCards
  final int id; // 削除するカードのユニークID

  const RoleCard(this.isTableCard, this.id);
}

// 役カードのセット
class Role {
  final List<RoleCard> cards; // 固定長配列
  final bool isStraightFlush; // true = ストレート フラッシュ, false = スリーカード

  const Role(this.cards, this.isStraightFlush);
}
