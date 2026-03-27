import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:word_memory_app/model/word_model.dart';

class QuestBoardMyWidget extends StatefulWidget {
  final Box<WordModel> box;

  const QuestBoardMyWidget({super.key, required this.box});

  @override
  State<QuestBoardMyWidget> createState() => _QuestBoardMyWidgetState();
}

class _QuestBoardMyWidgetState extends State<QuestBoardMyWidget> {
  late WordModel currentQuestion;
  List<String> choices = [];
  String correctAnswer = "";

  @override
  void initState() {
    super.initState();
    generateQuestion();
  }

  void generateQuestion() {
    final allWords = widget.box.values.toList();

    if (allWords.length < 4) return;

    allWords.shuffle();

    currentQuestion = allWords.first;
    correctAnswer = currentQuestion.meaning;

    final wrongAnswers = allWords
        .where((w) => w.meaning != correctAnswer)
        .take(3)
        .map((w) => w.meaning)
        .toList();

    choices = [correctAnswer, ...wrongAnswers];
    choices.shuffle();

    setState(() {});
  }

  void checkAnswer(String selected) {
    final isCorrect = selected == correctAnswer;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(isCorrect ? "ถูกต้อง 🎉" : "ผิด ❌"),
        content: Text("คำตอบคือ: $correctAnswer"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              generateQuestion();
            },
            child: const Text("ข้อต่อไป"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.box.length < 4) {
      return const Center(child: Text("ต้องมีคำอย่างน้อย 4 คำ"));
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Text(
                  currentQuestion.word,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                Text(
                  "(${currentQuestion.partOfSpeech})",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          Expanded(
            child: GridView.builder(
              itemCount: choices.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final choice = choices[index];

                return InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => checkAnswer(choice),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: [
                        BoxShadow(blurRadius: 4, color: Colors.black12),
                      ],
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          choice,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
