import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:word_memory_app/model/word_model.dart';
import 'package:word_memory_app/widget/add_board.dart';
import 'package:word_memory_app/widget/card_board.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<WordModel> cards = [];
  late Box<WordModel> box;

  @override
  void initState() {
    super.initState();
    box = Hive.box<WordModel>('cardsBox');
    _loadCards();
  }

  void _loadCards() {
    cards = box.values.toList();
  }

  void addCard(String word, String partOfSpeech, String meaning) {
    final newWord = WordModel(
      word: word,
      partOfSpeech: partOfSpeech,
      meaning: meaning,
    );

    box.add(newWord);

    setState(() {
      cards = box.values.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Word Memory'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.description_sharp)),
              Tab(icon: Icon(Icons.list_sharp)),
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            if (cards.length < 2)
              const Center(child: Text("ต้องการการ์ดอย่างน้อย 2 ใบ"))
            else
              CardBoardMyWidget(box: box),
            AddBoardMyWidget(onAdd: addCard, box: box,),
          ],
        ),
      ),
    );
  }
}
