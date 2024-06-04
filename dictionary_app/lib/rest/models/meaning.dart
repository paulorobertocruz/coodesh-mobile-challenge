import 'package:json_annotation/json_annotation.dart';

import 'definition.dart';
part 'meaning.g.dart';

@JsonSerializable()
class Meaning {
  Meaning({
    required this.partOfSpeech,
    required this.definitions,
  });

  factory Meaning.fromJson(Map<String, dynamic> json) =>
      _$MeaningFromJson(json);

  final String partOfSpeech;

  final List<Definition> definitions;

  Map<String, dynamic> toJson() => _$MeaningToJson(this);
}
