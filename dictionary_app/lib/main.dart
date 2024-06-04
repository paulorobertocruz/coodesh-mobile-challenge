import 'dart:io';

import 'package:dictionary_app/ui/pages/word_detatail_page/word_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import 'ui/pages/word_list_page/word_list_page.dart';

void main() async {
  final path = Directory.current.path;
  Hive.init(path);
  
  final box = await Hive.openBox('testBox');

  runApp(const DictionaryApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const WordListPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'details/:word',
          builder: (BuildContext context, GoRouterState state) {
            final String word = state.pathParameters['word'] ?? "";
            return WordDetailPage(word: word);
          },
        ),
      ],
    ),
  ],
);

class DictionaryApp extends StatelessWidget {
  const DictionaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: "Dictionary",
    );
  }
}
