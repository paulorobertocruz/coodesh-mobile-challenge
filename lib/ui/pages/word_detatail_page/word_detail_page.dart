import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/usecases/word_usecase.dart';

class WordDetailPage extends StatefulWidget {
  const WordDetailPage({
    super.key,
    required this.word,
    required this.usecase,
  });

  final String word;
  final WordUsecase usecase;

  @override
  State<WordDetailPage> createState() => _WordDetailPageState();
}

class _WordDetailPageState extends State<WordDetailPage> {
  @override
  void initState() {
    widget.usecase.addHistory(widget.word);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(widget.word),
              ),
              FutureBuilder(
                future: widget.usecase.getWord(widget.word),
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
                      Center(child: Text(data.phonetic)),
                      ...data.phonetics
                          .map((phonetic) => Text(phonetic.audio ?? "")),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Text(
                          "Meanings",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      ...data.meanings.map(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: const Text("Voltar"),
                    ),
                    FutureBuilder(
                        future: widget.usecase.isFavorite(widget.word),
                        builder: (context, snapshot) {
                          final isFavorite = snapshot.data ?? false;

                          return GestureDetector(
                            onTap: () async {
                              await widget.usecase
                                  .toggleWordFavorite(widget.word);
                              if (context.mounted) {
                                context.pop();
                              }
                            },
                            child: Icon(
                              isFavorite
                                  ? Icons.star
                                  : Icons.star_border_outlined,
                              color: isFavorite ? Colors.yellow : null,
                            ),
                          );
                        }),
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
