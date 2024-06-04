import 'package:dictionary_app/domain/repositories/word_repository.dart';
import 'package:dictionary_app/domain/entities/word.dart';
import '../datasources/word_hive_datasource.dart';
import '../datasources/word_rest_datasource.dart';
import '../datasources/word_file_datasource.dart';

class WordRepositoryImpl extends WordRepository {
  final WordFileDatasource fileDatasource;
  final WordHiveDatasource hiveDatasource;
  final WordRestDatasource restDatasource;

  WordRepositoryImpl({
    required this.hiveDatasource,
    required this.restDatasource,
    required this.fileDatasource,
  });

  @override
  Future<WordEntity> getWord(String word) async {
    final hasWord = await hiveDatasource.hasWord(word);

    if (hasWord) {
      final wordModel = hiveDatasource.getWord(word);
      return wordModel.toEntity();
    }

    final wordModel = await restDatasource.getWord(word);
    hiveDatasource.setWord(wordModel);

    return wordModel.toEntity();
  }

  @override
  Future<List<String>> getWords() async {
    return fileDatasource.getWords();
  }

  @override
  Future<List<String>> getHistory() {
    return hiveDatasource.getHistory();
  }

  @override
  Future<void> addHistory(String word) {
    return hiveDatasource.addHistory(word);
  }

  @override
  Future<void> toggleWordFavorite(String word) {
    return hiveDatasource.toggleWordFavorite(word);
  }

  @override
  Future<List<String>> getLikes() {
    return hiveDatasource.getLikes();
  }
}
