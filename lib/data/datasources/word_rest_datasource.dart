import 'package:dictionary_app/data/models/word.dart';
import 'package:dictionary_app/data/rest/rest_client.dart';

class WordRestDatasource {
  final RestClient restClient;

  WordRestDatasource({
    required this.restClient,
  });

  Future<Word> getWord(String word) async {
    try {
      final response = await restClient.word(word);
      return response.first;
    } catch (e) {
      throw Exception();
    }
  }
}
