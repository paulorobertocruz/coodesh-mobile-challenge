import 'package:dictionary_app/data/models/word.dart';
import 'package:hive/hive.dart';

class WordHiveDatasource {
  final Box cache;
  final Box profile;

  WordHiveDatasource({
    required this.cache,
    required this.profile,
  });

  Future<bool> hasWord(String word) async => cache.containsKey(word);

  Word getWord(String word) {
    final Map<String, dynamic> map = cache.get(word);
    return Word.fromJson(map);
  }

  Future<void> setWord(Word word) {
    return cache.put(word.word, word.toJson());
  }

  Future<List<String>> getHistory() async {
    return (await profile.get("history", defaultValue: []) as List)
        .cast<String>();
  }

  Future<void> addHistory(String word) async {
    final List history = await profile.get("history", defaultValue: <String>[]);
    if (!history.contains(word)) {
      final historySet = {word, ...history};
      await profile.put("history", historySet.toList());
    }
  }

  Future<void> toggleWordFavorite(String word) async {
    final List<String> likes =
        await profile.get("likes", defaultValue: <String>[]);
    final likesSet = likes.toSet();

    if (likesSet.contains(word)) {
      likesSet.remove(word);
    } else {
      likesSet.add(word);
    }

    await profile.put("likes", likesSet.toList());
  }

  Future<List<String>> getLikes() async {
    return (await profile.get("likes", defaultValue: []) as List)
        .cast<String>();
  }
}
