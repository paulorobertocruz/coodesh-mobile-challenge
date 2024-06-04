import 'package:json_annotation/json_annotation.dart';
part 'definition.g.dart';

@JsonSerializable()
class Definition {
  Definition({
    required this.definition,
  });

  factory Definition.fromJson(Map<String, dynamic> json) =>
      _$DefinitionFromJson(json);

  final String definition;

  Map<String, dynamic> toJson() => _$DefinitionToJson(this);
}
