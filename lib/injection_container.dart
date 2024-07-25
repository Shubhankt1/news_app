import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/features/daily_news/data/repository/article_repo_impl.dart';
import 'package:news_app/features/daily_news/data/sources/remote/news_api_service.dart';
import 'package:news_app/features/daily_news/domain/repository/article_repo.dart';
import 'package:news_app/features/daily_news/domain/usecases/get_articles.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';

final sL = GetIt.instance;

Future<void> initDependencies() async {
  // Dio
  sL.registerSingleton<Dio>(Dio());

  // News API
  sL.registerSingleton<NewsApiService>(NewsApiService(sL()));

  // Articles Repo
  sL.registerSingleton<ArticleRepo>(ArticleRepoImpl(sL()));

  // GetArticles Usecase
  sL.registerSingleton<GetArticlesUsecase>(GetArticlesUsecase(sL()));

  // Blocs
  sL.registerFactory<RemoteArticleBloc>(
    () => RemoteArticleBloc(sL()),
  );
}
