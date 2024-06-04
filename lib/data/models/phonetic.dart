import 'package:json_annotation/json_annotation.dart';
part 'phonetic.g.dart';

@JsonSerializable()
class Phonetic {
  Phonetic({
    this.audio,
    required this.text,
  });

  factory Phonetic.fromJson(Map<String, dynamic> json) =>
      _$PhoneticFromJson(json);

  final String? audio;
  final String text;

  Map<String, dynamic> toJson() => _$PhoneticToJson(this);
}
