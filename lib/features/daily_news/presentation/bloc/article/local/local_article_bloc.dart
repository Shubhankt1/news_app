import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/daily_news/domain/usecases/get_saved_articles.dart';
import 'package:news_app/features/daily_news/domain/usecases/remove_article.dart';
import 'package:news_app/features/daily_news/domain/usecases/save_article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_state.dart';

class LocalArticleBloc extends Bloc<LocalArticleEvent, LocalArticleState> {
  final GetSavedArticlesUsecase _getSavedArticlesUsecase;
  final SaveArticleUsecase _saveArticleUsecase;
  final RemoveArticleUsecase _removeArticleUsecase;

  LocalArticleBloc(
    this._getSavedArticlesUsecase,
    this._saveArticleUsecase,
    this._removeArticleUsecase,
  ) : super(const LocalArticlesLoading()) {
    on<GetSavedArticles>(onGetSavedArticles);
    on<RemoveArticle>(onRemoveArticle);
    on<SaveArticle>(onSaveArticle);
  }

  void onGetSavedArticles(
    GetSavedArticles event,
    Emitter<LocalArticleState> emit,
  ) async {
    final articles = await _getSavedArticlesUsecase();
    emit(LocalArticlesDone(articles));
  }

  void onRemoveArticle(
    RemoveArticle removeArticle,
    Emitter<LocalArticleState> emit,
  ) async {
    await _removeArticleUsecase(params: removeArticle.article);
    final articles = await _getSavedArticlesUsecase();
    emit(LocalArticlesDone(articles));
  }

  void onSaveArticle(
    SaveArticle saveArticle,
    Emitter<LocalArticleState> emit,
  ) async {
    log(saveArticle.article!.title.toString());
    await _saveArticleUsecase(params: saveArticle.article);
    final articles = await _getSavedArticlesUsecase();
    emit(LocalArticlesDone(articles));
  }
}
