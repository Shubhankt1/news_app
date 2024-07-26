import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/features/daily_news/data/repository/article_repo_impl.dart';
import 'package:news_app/features/daily_news/data/sources/local/app_database.dart';
import 'package:news_app/features/daily_news/data/sources/remote/news_api_service.dart';
import 'package:news_app/features/daily_news/domain/repository/article_repo.dart';
import 'package:news_app/features/daily_news/domain/usecases/get_articles.dart';
import 'package:news_app/features/daily_news/domain/usecases/get_saved_articles.dart';
import 'package:news_app/features/daily_news/domain/usecases/remove_article.dart';
import 'package:news_app/features/daily_news/domain/usecases/save_article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';

final sL = GetIt.instance;

Future<void> initDependencies() async {
  // Create DB
  final dB = await $FloorAppDatabase.databaseBuilder('app_db.db').build();
  sL.registerSingleton<AppDatabase>(dB);

  // Dio
  sL.registerSingleton<Dio>(Dio());

  // News API
  sL.registerSingleton<NewsApiService>(NewsApiService(sL()));

  // Articles Repo
  sL.registerSingleton<ArticleRepo>(ArticleRepoImpl(sL(), sL()));

  // GetArticles Usecase
  sL.registerSingleton<GetArticlesUsecase>(GetArticlesUsecase(sL()));

  // Get Saved Article Usecase
  sL.registerSingleton<GetSavedArticlesUsecase>(GetSavedArticlesUsecase(sL()));

  // Save Article Usecase
  sL.registerSingleton<SaveArticleUsecase>(SaveArticleUsecase(sL()));

  // Remove Article Usecase
  sL.registerSingleton<RemoveArticleUsecase>(RemoveArticleUsecase(sL()));

  // Blocs
  sL.registerFactory<RemoteArticleBloc>(
    () => RemoteArticleBloc(sL()),
  );

  sL.registerFactory<LocalArticleBloc>(
    () => LocalArticleBloc(sL(), sL(), sL()),
  );
}
