import 'package:dictionary_app/rest/rest_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WordDetailPage extends StatelessWidget {
  const WordDetailPage({
    super.key,
    required this.word,
  });

  final String word;

  @override
  Widget build(BuildContext context) {
    final rest = RestClient(Dio());

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(word),
              ),
              FutureBuilder(
                future: rest.word(word),
                builder: (context, snapshot) {
                  final data = snapshot.data;

                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (data == null) {
                    return const Center(
                      child: Text("sem dados na api"),
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: Text(data.first.phonetic)),
                      ...data.first.phonetics
                          .map((phonetic) => Text(phonetic.audio ?? "")),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Text(
                          "Meanings",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      ...data.first.meanings.map(
                        (meaning) => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...meaning.definitions.map(
                                (definition) => DefinitionWidget(
                                  partOfSpeech: meaning.partOfSpeech,
                                  definition: definition.definition,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: const Text("Voltar"),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Proxima"),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DefinitionWidget extends StatelessWidget {
  const DefinitionWidget({
    super.key,
    required this.partOfSpeech,
    required this.definition,
  });

  final String partOfSpeech;
  final String definition;

  @override
  Widget build(BuildContext context) {
    return Text("$partOfSpeech - $definition");
  }
}
