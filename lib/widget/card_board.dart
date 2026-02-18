import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class CardBoardMyWidget extends StatelessWidget {
  const CardBoardMyWidget({super.key});

  final List<Map<String, String>> cards = const [
    {"front": "แมว", "back": "Cat"},
    {"front": "หมา", "back": "Dog"},
  ];

  @override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flashcard")),
      body: CardSwiper(
        cardsCount: cards.length,
        cardBuilder: (context, index, _, __) {
          return FlipCard(
            key: UniqueKey(),
            direction: FlipDirection.HORIZONTAL,
            front: Card(
              child: Center(
                child: Text(
                  cards[index]["front"]!,
                  style: const TextStyle(fontSize: 30),
                ),
              ),
            ),
            back: Card(
              color: Colors.blue,
              child: Center(
                child: Text(
                  cards[index]["back"]!,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}