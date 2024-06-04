import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'data/datasources/word_file_datasource.dart';
import 'data/datasources/word_hive_datasource.dart';
import 'data/datasources/word_rest_datasource.dart';
import 'data/repositories/word_repository_impl.dart';
import 'data/rest/rest_client.dart';
import 'domain/repositories/word_repository.dart';
import 'domain/usecases/word_usecase.dart';
import 'ui/pages/home_page/home_page.dart';
import 'ui/pages/word_detatail_page/word_detail_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  final cache = await Hive.openBox('cache');
  final profile = await Hive.openBox('profile');
  //cache.clear();
  //profile.clear();

  final get = GetIt.instance;

  get.registerSingleton(cache, instanceName: "cache");
  get.registerSingleton(profile, instanceName: "profile");

  get.registerSingleton(WordRestDatasource(restClient: RestClient(Dio())));
  get.registerSingleton(WordHiveDatasource(cache: cache, profile: profile));
  get.registerSingleton(WordFileDatasource());

  get.registerSingleton<WordRepository>(
    WordRepositoryImpl(
      hiveDatasource: get.get(),
      restDatasource: get.get(),
      fileDatasource: get.get(),
    ),
  );

  get.registerSingleton(WordUsecase(wordRepository: get.get()));

  runApp(const DictionaryApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return HomePage(
          usecase: GetIt.instance.get(),
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'details/:word',
          builder: (BuildContext context, GoRouterState state) {
            final String word = state.pathParameters['word'] ?? "";
            return WordDetailPage(
              word: word,
              usecase: GetIt.instance.get(),
            );
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
