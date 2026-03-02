import 'package:flutter/material.dart';

class AddBoardMyWidget extends StatelessWidget {
  final Function(String, String) onAdd;

  const AddBoardMyWidget({super.key, required this.onAdd});

  void _showAddDialog(BuildContext context) {
    final frontController = TextEditingController();
    final backController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("เพิ่มการ์ด"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: frontController,
              decoration: const InputDecoration(labelText: "Front"),
            ),
            TextField(
              controller: backController,
              decoration: const InputDecoration(labelText: "Back"),
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
              if (frontController.text.isNotEmpty &&
                  backController.text.isNotEmpty) {
                onAdd(frontController.text, backController.text);
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