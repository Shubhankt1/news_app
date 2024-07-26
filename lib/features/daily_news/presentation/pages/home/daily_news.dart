import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/core/widgets/custom_app_bar.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:news_app/features/daily_news/presentation/widgets/home/news_tile.dart';
import 'package:news_app/injection_container.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sL<LocalArticleBloc>(),
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
          builder: (BuildContext context, RemoteArticleState state) {
            if (state is RemoteArticlesLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (state is RemoteArticlesError) {
              debugPrint(state.error!.error.toString());
              // debugPrintStack();
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.refresh_rounded),
                    Text(
                      kDebugMode
                          ? state.error!.error.toString()
                          : "Oops! Something went wrong",
                    ),
                  ],
                ),
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
                        return NewsTile(
                            article: state.articles![index],
                            onSave: () {
                              debugPrint(state.articles![index].title);
                              BlocProvider.of<LocalArticleBloc>(context).add(
                                SaveArticle(
                                  state.articles![index],
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                ..clearSnackBars()
                                ..showSnackBar(
                                  SnackBar(
                                    elevation: 16,
                                    behavior: SnackBarBehavior.floating,
                                    duration: const Duration(seconds: 2),
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    backgroundColor: Colors.white,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    content: const Text(
                                      'Saved Article!',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                );
                            });
                      },
                    ),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
