import 'package:dictionary_app/domain/entities/meaning.dart';
import 'package:dictionary_app/domain/entities/phonetic.dart';
import 'package:dictionary_app/domain/entities/word.dart';
import 'package:json_annotation/json_annotation.dart';
import 'meaning.dart';
import 'phonetic.dart';

part 'word.g.dart';

@JsonSerializable(explicitToJson: true)
class Word {
  const Word({
    required this.word,
    required this.phonetic,
    required this.phonetics,
    required this.meanings,
  });

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);

  final String word;
  final String? phonetic;
  final List<Phonetic> phonetics;
  final List<Meaning> meanings;

  Map<String, dynamic> toJson() => _$WordToJson(this);

  WordEntity toEntity() {
    return WordEntity(
      word: word,
      phonetic: phonetic ?? "",
      phonetics: phonetics
          .map((p) => PhoneticEntity(
                text: p.text,
                audio: p.audio,
              ))
          .toList(),
      meanings: meanings
          .map(
            (m) => MeaningEntity(
              partOfSpeech: m.partOfSpeech,
              definitions: m.definitions
                  .map(
                    (d) => DefinitionEntity(
                      definition: d.definition,
                    ),
                  )
                  .toList(),
            ),
          )
          .toList(),
    );
  }
}
