import 'dart:io';

import 'package:dio/dio.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/data/models/article_model.dart';
import 'package:news_app/features/daily_news/data/sources/local/app_database.dart';
import 'package:news_app/features/daily_news/data/sources/remote/news_api_service.dart';
import 'package:news_app/features/daily_news/domain/entities/article_entity.dart';
import 'package:news_app/features/daily_news/domain/repository/article_repo.dart';

class ArticleRepoImpl implements ArticleRepo {
  final NewsApiService _newsApiService;
  final AppDatabase _appDatabase;

  ArticleRepoImpl(this._newsApiService, this._appDatabase);

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticle() async {
    try {
      // API Call
      final httpResponse = await _newsApiService.getNewsArticles(
        apiKey: newsApiKey,
        sources: sources,
        // country: countryQuery,
        // category: categoryQuery,
      );

      // If Success
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        // If Unsuccessful
        return DataFailed(
          DioException(
            requestOptions: httpResponse.response.requestOptions,
            error: httpResponse.response.statusMessage,
            type: DioExceptionType.badResponse,
            response: httpResponse.response,
          ),
        );
      }
    } on DioException catch (e) {
      // If Error
      return DataFailed(e);
    }
  }

  @override
  Future<void> deleteArticle(ArticleEntity article) {
    return _appDatabase.articleDAO.deleteArticle(
      ArticleModel.fromEntity(article),
    );
  }

  @override
  Future<List<ArticleModel>> getSavedArticles() {
    return _appDatabase.articleDAO.getArticles();
  }

  @override
  Future<void> saveArticle(ArticleEntity article) {
    return _appDatabase.articleDAO.insertArticle(
      ArticleModel.fromEntity(article),
    );
  }
}
