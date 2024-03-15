import 'package:gg_poker/features/blackjack/game/logic/card/suit.dart';
import 'package:gg_poker/features/blackjack/game/logic/card/value.dart';

class Card {
  final Suit suit;
  final Value value;
  bool isDisclosed;

  Card({required this.suit, required this.value, required this.isDisclosed});

  Card copyWith({Suit? suit, Value? value, bool? isDisclosed}) {
    return Card(
      suit: suit ?? this.suit,
      value: value ?? this.value,
      isDisclosed: isDisclosed ?? this.isDisclosed,
    );
  }
}
