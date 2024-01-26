import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_riverpod/data/provider/news_provider.dart';
import 'package:news_app_riverpod/domain/models/news_model.dart';
import 'package:news_app_riverpod/presentation/widgets/news_card.dart';
import 'package:news_app_riverpod/presentation/widgets/search_field.dart';
import 'package:news_app_riverpod/presentation/view/home_detail_view.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(newsProvider.notifier).loadNews();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NewsModel news = ref.watch(newsProvider).newsModel;
    bool isLoading = ref.watch(newsProvider).isLoading;

    return Scaffold(
      backgroundColor: const Color(0xffF8F9FD),
      body: SafeArea(
        child: Column(
          children: [
            const SearchField(),
            isLoading
                ? CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: news.articles!.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        final item = news.articles![index];
                        return NewsCard(
                          article: item,
                          onTap: () {
                            if (item.url != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HomeDetailView(Url_path: item.url!.trim())),
                              );
                            }
                          },
                        );
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
