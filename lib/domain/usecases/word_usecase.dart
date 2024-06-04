import '../entities/word.dart';
import '../repositories/word_repository.dart';

enum WordFilter {
  main,
  history,
  likes,
}

class WordUsecase {
  final WordRepository wordRepository;

  WordUsecase({required this.wordRepository});

  Future<List<String>> getWords({
    WordFilter filter = WordFilter.main,
  }) {
    return switch (filter) {
      WordFilter.main => wordRepository.getWords(),
      WordFilter.history => wordRepository.getHistory(),
      WordFilter.likes => wordRepository.getLikes(),
    };
  }

  Future<WordEntity> getWord(String word) => wordRepository.getWord(word);

  Future<void> toggleWordFavorite(String word) =>
      wordRepository.toggleWordFavorite(word);

  Future<void> addHistory(String word) => wordRepository.addHistory(word);

  Future<bool> isFavorite(String word) async {
    final favorites = await wordRepository.getLikes();
    return favorites.contains(word);
  }
}
