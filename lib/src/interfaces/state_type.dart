// 状態
enum StateType {
  title,
  start,
  drawActionCard,
  drawedActionCard,
  limitActionCard,
  limitActionCardAnim,

  rollDice,
  diceRolled,
  diceSame,
  diceDifferent,

  choiceActionCard,
  rakosHelp,
  rakosHelpAnim,
  surfingAgain,
  surfingAgainAnim,
  rakosResearch,
  rakosResearchAnim,

  actioned,
  choiceGoal,
  success,
  successAnim,
  discoverRakko,
  miss,
  missAnim,

  choiceDice,
  diceChoiced,
  round,
  moveForward,
  helpRakko,
  cannotHelpRakko,
  openSeaCard,
  openedSeaCard,

  removeDebri,
  removeDebriAnim,

  gameOver,

  choiceRepairBoat,
  repairBoat,
  repairBoatAnim
}
