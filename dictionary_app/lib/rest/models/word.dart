import 'package:json_annotation/json_annotation.dart';
import 'meaning.dart';
import 'phonetic.dart';

part 'word.g.dart';

@JsonSerializable()
class Word {
  const Word({
    required this.word,
    required this.phonetic,
    required this.phonetics,
    required this.meanings,
  });

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);

  final String word;
  final String phonetic;
  final List<Phonetic> phonetics;
  final List<Meaning> meanings;

  Map<String, dynamic> toJson() => _$WordToJson(this);
}
