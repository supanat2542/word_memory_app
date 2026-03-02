import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:word_memory_app/model/word_model.dart';

class CardBoardMyWidget extends StatelessWidget {
  const CardBoardMyWidget({super.key, required this.cards });

  final List<WordModel> cards;

  @override
  Widget build(BuildContext context) {
    return CardSwiper(
      cardsCount: cards.length,
      cardBuilder: (context, index, _, __) {
        return FlipCard(
          key: UniqueKey(),
          direction: FlipDirection.HORIZONTAL,
          front: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    cards[index].word,
                    style: const TextStyle(fontSize: 30),
                  ),
                  Text(
                    "${cards[index].partOfSpeech}.",
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
          ),
          back: Card(
            color: Colors.blue,
            child: Center(
              child: Text(
                cards[index].meaning,
                style: const TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}
