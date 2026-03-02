import 'package:hive/hive.dart';

part 'word_model.g.dart';

@HiveType(typeId: 0)
class WordModel {

  @HiveField(0)
  final String word;

  @HiveField(1)
  final String partOfSpeech;

  @HiveField(2)
  final String meaning;

  WordModel({
    required this.word,
    required this.partOfSpeech,
    required this.meaning,
  });
}