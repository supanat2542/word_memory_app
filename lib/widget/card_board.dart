import 'dart:math';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:word_memory_app/model/word_model.dart';

class CardBoardMyWidget extends StatefulWidget {
  const CardBoardMyWidget({super.key, required this.box});

  final Box<WordModel> box;

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

  Future<void> shuffleCards() async {
    final items = widget.box.values.toList();

    if (items.isEmpty) return;

    items.shuffle(Random());

    await widget.box.clear(); // ลบทั้งหมด

    for (var item in items) {
      await widget.box.add(item); // เพิ่มกลับตามลำดับใหม่
    }
    setState(() {
      currentIndex = 0;
    });

    controller.moveTo(0);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.box.listenable(),
      builder: (context, Box<WordModel> box, _) {
        final cards = box.values.toList();

        if (cards.isEmpty) {
          return const Center(child: Text("ไม่มีการ์ด"));
        }

        return Column(
          children: [
            Expanded(
              child: CardSwiper(
                controller: controller,
                cardsCount: cards.length,
                onSwipe: (previousIndex, newIndex, direction) {
                  currentIndex = newIndex ?? 0;
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
                              cards[index].word,
                              style: const TextStyle(fontSize: 30),
                            ),
                            Text(
                              cards[index].partOfSpeech,
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
                          cards[index].meaning,
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
                    onPressed: cards.isEmpty
                        ? null
                        : () => speakWord(cards[currentIndex].word),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
