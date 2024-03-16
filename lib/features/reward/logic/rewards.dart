enum Reward {
  r02(5000, RewardMessage.jackpot),
  r03(30, RewardMessage.bigwin),
  r04(50, RewardMessage.bigwin),
  r05(1000, RewardMessage.bigwin),
  r06(60, RewardMessage.bigwin),
  r07(200, RewardMessage.bigwin),
  r08(10, RewardMessage.bigwin),
  r09(500, RewardMessage.bigwin),
  r10(100, RewardMessage.bigwin),
  r11(0, RewardMessage.oops),
  r12(5000, RewardMessage.jackpot),
  r13(40, RewardMessage.bigwin),
  r14(50, RewardMessage.bigwin),
  r15(1000, RewardMessage.bigwin),
  r16(80, RewardMessage.bigwin),
  r17(1000, RewardMessage.bigwin),
  r18(70, RewardMessage.bigwin),
  r19(550, RewardMessage.bigwin),
  r20(20, RewardMessage.bigwin),
  r01(70, RewardMessage.bigwin);

  final int value;
  final RewardMessage rewardMessage;

  const Reward(this.value, this.rewardMessage);
}

enum RewardMessage {
  jackpot('Jackpot'),
  bigwin('Big win'),
  oops('Oops');

  final String message;

  const RewardMessage(this.message);
}
