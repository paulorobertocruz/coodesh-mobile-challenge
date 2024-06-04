import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/usecases/word_usecase.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.usecase,
  });

  final WordUsecase usecase;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WordFilter wordFilter = WordFilter.main;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: wordFilter == WordFilter.main ? Colors.amber : null,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        wordFilter = WordFilter.main;
                      });
                    },
                    child: Text("Words List".toUpperCase()),
                  ),
                ),
                Container(
                  color: wordFilter == WordFilter.history ? Colors.amber : null,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        wordFilter = WordFilter.history;
                      });
                    },
                    child: Text("History".toUpperCase()),
                  ),
                ),
                Container(
                  color: wordFilter == WordFilter.likes ? Colors.amber : null,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        wordFilter = WordFilter.likes;
                      });
                    },
                    child: Text("Favorites".toUpperCase()),
                  ),
                ),
              ],
            ),
            FutureBuilder(
              future: widget.usecase.getWords(filter: wordFilter),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                

                final words = snapshot.data ?? [];

                return Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemCount: words.length,
                    itemBuilder: (context, index) {
                      final word = words[index];
                      return GestureDetector(
                        onTap: () {
                          context.go("/details/$word");
                        },
                        child: Container(
                          color: Colors.grey,
                          margin: const EdgeInsets.all(4),
                          child: Center(child: Text(word)),
                        ),
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
