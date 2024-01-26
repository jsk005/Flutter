import 'package:news_app_riverpod/core/constants/app_utils.dart';

class RetrofitURL {
  static const baseUrl = "https://newsapi.org";

  static const fetchNews = "/v2/top-headlines?country=kr&category=science&apiKey=${AppUtils.newsKey}";
  // https://newsapi.org/v2/top-headlines?country=kr&category=science&apiKey=094abddfda1944fb87d868677f3005ee

  static const fetchNewsBySearching = "/v2/everything?q={title}&apiKey=${AppUtils.newsKey}";

  static const String imageNotFound = 'https://www.charlotteathleticclub.com/assets/camaleon_cms/image-not-found-4a963b95bf081c3ea02923dceaeb3f8085e1a654fc54840aac61a57a60903fef.png';

}