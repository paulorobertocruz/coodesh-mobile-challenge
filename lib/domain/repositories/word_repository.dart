import '../entities/word.dart';

abstract class WordRepository {
  Future<List<String>> getWords();
  Future<WordEntity> getWord(String word);
  Future<void> toggleWordFavorite(String word);
  Future<void> addHistory(String word);
  Future<List<String>> getHistory();
  Future<List<String>> getLikes();
}
