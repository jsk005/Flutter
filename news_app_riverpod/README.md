### 개요
News APP은 Android 버전도 샘플로 많이 구현되어 있을 정도로 유명한 사이트 자료를 가져와서 구현하는 방법을 다루는 예제이다.<br/>
Flutter 버전으로 구현을 해보면서 벽에 부딪친 사항과 이를 해결하는 과정을 기록해두려고 하다보니 sub 폴더를 구성하게 되었다.

### Getting Started
Clean Architecture 구조를 지향하며 디렉토리 구조를 구현하고 있는데 아직은 부족한 상태다.<br/>
NewsDataResult.fromJson 부분 구현이 핵심사항이다. 이 부분을 잘못 구현하면 에러가 발생한다.<br/>
서버 데이터 구조가 Null 을 허용하는 변수인지 아닌지 여부 파악이 쉽지 않다. Retrofit 에서 에러가 발생하면 하나씩 수정해가면서 완성해야 한다.<br/>

```
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news_app_riverpod/domain/model/news_data.dart';

sealed class NewsDataResultBase {}

class NewsDataResultLoading extends NewsDataResultBase {}

class NewsDataResultError extends NewsDataResultBase {
  final String errMsg;

  NewsDataResultError({
    required this.errMsg,
  });
}

class NewsDataResult extends NewsDataResultBase {
  String? status;
  int? totalResults;
  List<NewsData>? articles;

  NewsDataResult({
    this.status,
    this.totalResults,
    this.articles,
  });

  NewsDataResult.fromJson(Map < String, dynamic > json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = <NewsData> [];
      json['articles'].forEach((v) {
        articles!.add(NewsData.fromJson(v));
      });
    }
  }
}
```

