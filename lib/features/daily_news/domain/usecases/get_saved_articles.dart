import 'package:news_app/core/usecases/usecase.dart';
import 'package:news_app/features/daily_news/domain/repository/article_repo.dart';
import 'package:news_app/features/daily_news/domain/entities/article_entity.dart';

class GetSavedArticlesUsecase implements Usecase<List<ArticleEntity>, void> {
  final ArticleRepo _articleRepo;

  GetSavedArticlesUsecase(this._articleRepo);

  @override
  Future<List<ArticleEntity>> call({void params}) {
    return _articleRepo.getSavedArticles();
  }
}
