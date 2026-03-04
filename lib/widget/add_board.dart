import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:word_memory_app/model/word_model.dart';

class AddBoardMyWidget extends StatelessWidget {
  final Function(String, String, String) onAdd;
  final Box<WordModel> box;

  const AddBoardMyWidget({super.key, required this.onAdd, required this.box});

void _showAddDialog(BuildContext context) {
  final wordController = TextEditingController();
  final meaningController = TextEditingController();
  String selectedPart = 'n.';

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text("เพิ่มการ์ด"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: wordController,
                    decoration: const InputDecoration(labelText: "Word"),
                  ),

                  const SizedBox(height: 12),

                  TextField(
                    controller: meaningController,
                    decoration: const InputDecoration(labelText: "Meaning"),
                  ),

                  const SizedBox(height: 16),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SegmentedButton<String>(
                      segments: const [
                        ButtonSegment(value: 'n.', label: Text('n.')),
                        ButtonSegment(value: 'v.', label: Text('v.')),
                        ButtonSegment(value: 'adj.', label: Text('adj.')),
                        ButtonSegment(value: 'adv.', label: Text('adv.')),
                        ButtonSegment(value: 'phr.', label: Text('phr.')),
                        ButtonSegment(value: 'idm.', label: Text('idm.')),
                      ],
                      selected: {selectedPart},
                      onSelectionChanged: (Set<String> newSelection) {
                        setState(() {
                          selectedPart = newSelection.first;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("ยกเลิก"),
              ),
              ElevatedButton(
                onPressed: () {
                  if (wordController.text.isNotEmpty &&
                      meaningController.text.isNotEmpty) {
                    onAdd(
                      wordController.text,
                      selectedPart,
                      meaningController.text,
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text("เพิ่ม"),
              ),
            ],
          );
        },
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: box.listenable(),
            builder: (context, Box<WordModel> box, _) {
              final cards = box.values.toList();
              if (cards.isEmpty) {
                return const Center(child: Text("ยังไม่มีข้อมูล"));
              } else {
                return SingleChildScrollView(
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Word')),
                      DataColumn(label: Text('Part')),
                      DataColumn(label: Text('Meaning')),
                    ],
                    rows: cards.map((card) {
                      return DataRow(
                        cells: [
                          DataCell(Text(card.word)),
                          DataCell(Text(card.partOfSpeech)),
                          DataCell(Text(card.meaning)),
                        ],
                      );
                    }).toList(),
                  ),
                );
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text("เพิ่มการ์ด"),
            onPressed: () => _showAddDialog(context),
          ),
        ),
      ],
    );
  }
}
