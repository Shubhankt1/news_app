import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/features/daily_news/data/models/article_model.dart';

part 'news_api_service.g.dart';

@RestApi(baseUrl: newsApiBaseUrl)
abstract class NewsApiService {
  factory NewsApiService(Dio dio) = _NewsApiService;

  @GET('/top-headlines')
  Future<HttpResponse<List<ArticleModel>>> getNewsArticles({
    @Query("apiKey") String? apiKey,
    @Query("sources") String? sources,
    // @Query("country") String? country,
    // @Query("category") String? category,
  });
}
