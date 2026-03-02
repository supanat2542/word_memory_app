import 'package:flutter/material.dart';
import 'package:word_memory_app/widget/add_board.dart';

import 'widget/card_board.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void addCard(String front, String back) {
    setState(() {
      cards.add({"front": front, "back": back});
    });
  }


  final List<Map<String, String>> cards = [
    {"front": "แมว", "back": "Cat"},
    {"front": "หมา", "back": "Dog"},
  ];

  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
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
        body:TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            CardBoardMyWidget(cards: cards),
            AddBoardMyWidget(onAdd: addCard),
          ],
        ),
      ),
    );
  }
}