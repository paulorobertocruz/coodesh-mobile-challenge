

import 'meaning.dart';
import 'phonetic.dart';

class WordEntity {
  WordEntity({
    required this.word,
    required this.meanings,
    required this.phonetic,
    required this.phonetics,
  });
  final String word;
  final String phonetic;
  final List<PhoneticEntity> phonetics;
  final List<MeaningEntity> meanings;
}
