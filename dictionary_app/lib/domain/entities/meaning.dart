class DefinitionEntity {
  DefinitionEntity({
    required this.definition,
  });
  final String definition;
}

class MeaningEntity {
  MeaningEntity({
    required this.partOfSpeech,
    required this.definitions,
  });
  final String partOfSpeech;

  final List<DefinitionEntity> definitions;
}
