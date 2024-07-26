import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/core/widgets/custom_app_bar.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:news_app/features/daily_news/presentation/widgets/home/news_tile.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
        builder: (BuildContext context, RemoteArticleState state) {
          if (state is RemoteArticlesLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (state is RemoteArticlesError) {
            return const Center(
              child: Icon(Icons.refresh_rounded),
            );
          }
          if (state is RemoteArticlesDone) {
            debugPrint('Number of articles: ${state.articles!.length}');
            return Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Transform.translate(
                    offset: const Offset(0.0, -kToolbarHeight),
                    child: SvgPicture.asset(topSvg),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: SvgPicture.asset(bottomSvg),
                ),
                Center(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.articles!.length,
                    itemBuilder: (context, index) {
                      return NewsTile(article: state.articles![index]);
                    },
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
