import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:word_memory_app/widget/add_board.dart';
import 'package:word_memory_app/widget/card_board.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> cards = [];
  final box = Hive.box('cardsBox');

  void initState() {
    super.initState();
    _loadCards();
  }

  void _loadCards() {
    final stored = box.get('cards', defaultValue: []);

    cards = List<Map<String, String>>.from(
      stored.map((e) => Map<String, String>.from(e)),
    );
  }

  void addCard(String front, String back) {
    final newCard = {"front": front, "back": back};
    final stored = box.get('cards', defaultValue: []);
    List updated = List.from(stored);

    updated.add(newCard);
    box.put('cards', updated);

    setState(() {
      cards = List<Map<String, String>>.from(
        updated.map((e) => Map<String, String>.from(e)),
      );
    });
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TabBar Sample'),
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
              CardBoardMyWidget(cards: cards),
            AddBoardMyWidget(onAdd: addCard),
          ],
        ),
      ),
    );
  }
}
