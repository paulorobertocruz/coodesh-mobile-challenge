import 'dart:convert';

import 'package:flutter/services.dart';

class WordFileDatasource {
  Future<List<String>> getWords() async {
    final response =
        await rootBundle.loadString("assets/json/words_dictionary.json");
    final Map<String, dynamic> result = jsonDecode(response);
    return result.keys.toList();
  }
}
