import 'package:flutter/material.dart' hide Card;
import 'package:flutter_svg/svg.dart';
import 'package:gg_poker/features/blackjack/game/logic/card/card.dart';
import 'package:gg_poker/features/blackjack/game/logic/card/value.dart';

class CardFront extends StatelessWidget {
  const CardFront({super.key, required this.card});

  final Card card;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    String cardTitle;
    switch (card.value) {
      case Value.ace:
        cardTitle = 'A';
        break;
      case Value.king:
        cardTitle = 'K';
        break;
      case Value.queen:
        cardTitle = 'Q';
        break;
      case Value.jack:
        cardTitle = 'J';
        break;
      default:
        cardTitle = card.value.intValue.toString();
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.elliptical(14, 14)),
        border: Border.all(color: card.suit.color, width: 2),
      ),
      child: Stack(
        children: [
          SvgPicture.asset(
            'assets/cards/${card.value.name}.svg',
            colorFilter: ColorFilter.mode(card.suit.color, BlendMode.srcIn),
            width: width / 4,
            height: height / 6,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              cardTitle,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}










// @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//     const maxFiguresInRow = 2;
//     const maxFiguresInColumn = 6;
//     final shortestFigureSide = width / 16;

//     double figureSide = width / 18;
//     int runSpacingDivider = 6;
//     int spacingDivider = 4;
//     if (card.value.intValue <= 8) {
//       figureSide = width / 16;
//       runSpacingDivider = 8;
//       spacingDivider = 4;
//     }
//     if (card.value == Value.nine || card.value == Value.ten) {
//       figureSide = width / 20;
//       runSpacingDivider = 6;
//       spacingDivider = 3;
//     }
//     if (card.value == Value.jack ||
//         card.value == Value.queen ||
//         card.value == Value.king) {
//       figureSide = width / 24;
//       runSpacingDivider = 4;
//       spacingDivider = 2;
//     }

//     BoxShape shape;
//     double angle;
//     double runSpacing = figureSide / runSpacingDivider;
//     double spacing = figureSide / spacingDivider;
//     double widthConstaint = width / 4;
//     double heightConstaint = height / 3 - kToolbarHeight * 1.5;
//     if (card.value == Value.jack ||
//         card.value == Value.queen ||
//         card.value == Value.king) {
//       shape = BoxShape.rectangle;
//       angle = pi / 4;
//       runSpacing = figureSide / 2;
//     } else {
//       shape = BoxShape.circle;
//       angle = 0;
//     }

//     return Container(
//       constraints: BoxConstraints(
//         minWidth: widthConstaint,
//         maxWidth: widthConstaint,
//         minHeight: heightConstaint,
//         maxHeight: heightConstaint,
//       ),
//       padding: EdgeInsets.symmetric(
//           horizontal: spacing * 2, vertical: runSpacing * 2),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: const BorderRadius.all(Radius.elliptical(14, 14)),
//         border: Border.all(color: card.suit.color),
//       ),
//       child: Wrap(
//         runSpacing: runSpacing,
//         spacing: spacing,
//         alignment: WrapAlignment.center,
//         runAlignment: WrapAlignment.center,
//         children: List.generate(card.value.intValue, (index) {
//           return Transform.rotate(
//             angle: angle,
//             child: Container(
//               width: figureSide,
//               height: figureSide,
//               decoration: BoxDecoration(
//                 shape: shape,
//                 color: card.suit.color,
//               ),
//             ),
//           );
//         }),
//       ),
//     );
//   }