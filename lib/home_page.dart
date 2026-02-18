import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:hive_flutter/hive_flutter.dart';

import 'widget/card_board.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TabBar Sample'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.cloud_outlined)),
              Tab(icon: Icon(Icons.beach_access_sharp)),
              Tab(icon: Icon(Icons.brightness_5_sharp)),
            ],
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            CardBoardMyWidget(),
            Center(child: Text("It's rainy here")),
            Center(child: Text("It's sunny here")),
          ],
        ),
      ),
    );
  }
}

// class _HomePageState extends State<HomePage> {
//   final box = Hive.box('wordsBox');

//   final TextEditingController wordController = TextEditingController();
//   final TextEditingController meaningController = TextEditingController();

//   void addWord() {
//     if (wordController.text.isNotEmpty &&
//         meaningController.text.isNotEmpty) {
//       box.add({
//         "word": wordController.text,
//         "meaning": meaningController.text,
//       });

//       wordController.clear();
//       meaningController.clear();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("แอปท่องจำ")),
//       body: Column(
//         children: [
//           Expanded(
//             child: ValueListenableBuilder(
//               valueListenable: box.listenable(),
//               builder: (context, Box box, _) {
//                 if (box.isEmpty) {
//                   return const Center(child: Text("ยังไม่มีคำศัพท์"));
//                 }

//                 return ListView.builder(
//                   itemCount: box.length,
//                   itemBuilder: (context, index) {
//                     final item = box.getAt(index);

//                     return ListTile(
//                       title: Text(item['word']),
//                       subtitle: Text(item['meaning']),
//                       trailing: IconButton(
//                         icon: const Icon(Icons.delete),
//                         onPressed: () => box.deleteAt(index),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Column(
//               children: [
//                 TextField(
//                   controller: wordController,
//                   decoration: const InputDecoration(
//                     labelText: "คำศัพท์",
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 TextField(
//                   controller: meaningController,
//                   decoration: const InputDecoration(
//                     labelText: "ความหมาย",
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: addWord,
//                   child: const Text("เพิ่มคำ"),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
