import 'package:flutter/material.dart';
import 'package:news_app_riverpod/core/constants/retrofit_url.dart';
import 'package:news_app_riverpod/domain/models/news_data.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NewsCard extends StatelessWidget {
  final NewsData article;
  final Function() onTap;

  const NewsCard({
    Key? key,
    required this.article,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromRGBO(209, 234, 255, 1),
        ),
        child: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: article.urlToImage == null ?
                  RetrofitURL.imageNotFound : article.urlToImage.toString(),
                  errorWidget: (context, string, _) {
                    return const Icon(Icons.error);
                  },
                  width: 130,
                  height: 130,
                  fit: BoxFit.cover,
                )
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 1,
              child: Text(
                article.title.toString(),
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
