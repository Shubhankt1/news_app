import 'package:news_app/core/usecases/usecase.dart';
import 'package:news_app/features/daily_news/domain/repository/article_repo.dart';
import 'package:news_app/features/daily_news/domain/entities/article_entity.dart';

class RemoveArticleUsecase implements Usecase<void, ArticleEntity> {
  final ArticleRepo _articleRepo;

  RemoveArticleUsecase(this._articleRepo);

  @override
  Future<void> call({ArticleEntity? params}) {
    return _articleRepo.deleteArticle(params!);
  }
}
