import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/core/usecases/usecase.dart';
import 'package:news_app/features/daily_news/domain/entities/article_entity.dart';
import 'package:news_app/features/daily_news/domain/repository/article_repo.dart';

class GetArticlesUsecase
    implements Usecase<DataState<List<ArticleEntity>>, void> {
  final ArticleRepo _articleRepo;

  GetArticlesUsecase(this._articleRepo);

  @override
  Future<DataState<List<ArticleEntity>>> call({void params}) {
    return _articleRepo.getNewsArticle();
  }
}
