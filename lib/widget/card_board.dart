import 'dart:math';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:word_memory_app/model/word_model.dart';

class CardBoardMyWidget extends StatefulWidget {
  const CardBoardMyWidget({super.key, required this.cards});
  final List<WordModel> cards;

  @override
  State<CardBoardMyWidget> createState() => _CardBoardMyWidgetState();
}

class _CardBoardMyWidgetState extends State<CardBoardMyWidget> {
  final CardSwiperController controller = CardSwiperController();
  final FlutterTts tts = FlutterTts();

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      shuffleCards();
    });
  }

  Future speakWord(String word) async {
    await tts.setLanguage("en-US");
    await tts.setSpeechRate(0.5);
    await tts.setPitch(1.0);
    await tts.speak(word);
  }

  void shuffleCards() {
    setState(() {
      widget.cards.shuffle(Random());
      currentIndex = 0;
    });

    controller.moveTo(0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CardSwiper(
            controller: controller,
            cardsCount: widget.cards.length,
            onSwipe: (previousIndex, newIndex, direction) {
              setState(() {
                currentIndex = newIndex ?? 0;
              });
              return true;
            },
            cardBuilder: (context, index, _, __) {
              return FlipCard(
                key: UniqueKey(),
                direction: FlipDirection.HORIZONTAL,
                front: SizedBox.expand(
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.cards[index].word,
                          style: const TextStyle(fontSize: 30),
                        ),
                        Text(
                          widget.cards[index].partOfSpeech,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                back: Card(
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      widget.cards[index].meaning,
                      style: const TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.shuffle_sharp),
                label: const Text("สุ่มการ์ด"),
                onPressed: () => {shuffleCards()},
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.volume_up_sharp),
                label: const Text("ฟังเสียง"),
                onPressed: () => {speakWord(widget.cards[currentIndex].word)},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
