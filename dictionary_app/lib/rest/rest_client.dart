import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'models/word.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: 'https://api.dictionaryapi.dev/api/v2/entries/en')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/{word}')
  Future<List<Word>> word(@Path('word') String word);
}
