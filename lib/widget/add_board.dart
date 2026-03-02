import 'package:flutter/material.dart';

class AddBoardMyWidget extends StatelessWidget {
  final Function(String, String, String) onAdd;

  const AddBoardMyWidget({super.key, required this.onAdd});

  void _showAddDialog(BuildContext context) {
    final wordController = TextEditingController();
    final partOfSpeechController = TextEditingController();
    final meaningController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("เพิ่มการ์ด"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: wordController,
              decoration: const InputDecoration(labelText: "Word"),
            ),
            TextField(
              controller: partOfSpeechController,
              decoration: const InputDecoration(labelText: "Part of Speech"),
            ),
            TextField(
              controller: meaningController,
              decoration: const InputDecoration(labelText: "Meaning"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("ยกเลิก"),
          ),
          ElevatedButton(
            onPressed: () {
              if (wordController.text.isNotEmpty &&
                  partOfSpeechController.text.isNotEmpty &&
                  meaningController.text.isNotEmpty) {
                onAdd(
                  wordController.text,
                  partOfSpeechController.text,
                  meaningController.text,
                );
                Navigator.pop(context);
              }
            },
            child: const Text("เพิ่ม"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        icon: const Icon(Icons.add),
        label: const Text("เพิ่มการ์ด"),
        onPressed: () => _showAddDialog(context),
      ),
    );
  }
}