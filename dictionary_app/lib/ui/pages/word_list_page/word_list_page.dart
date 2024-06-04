import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WordListPage extends StatelessWidget {
  const WordListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: DefaultAssetBundle.of(context)
              .loadString("assets/json/words_dictionary.json"),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final data = snapshot.data ?? "{}";

            final Map<String, dynamic> result = jsonDecode(data);
            final words = result.keys.toList();

            return ListView(
              children: words
                  .map((word) => GestureDetector(
                        onTap: () {
                          context.go("/details/$word");
                        },
                        child: Text(word),
                      ))
                  .toList(),
            );
          }),
    );
  }
}
