#### Retrofit 라이브러리를 활용 방법
https://pub.dev/packages/retrofit 사이트에 pubspec.yaml 에 추가할 라이브러리 정보가 나온다.<br/>

```
@GET('/item/{id}.json')
Future<NewsModel> getNewsModelDetail(@Path() int id);
```

Future<NewsModel> 에서 NewsModel은 서버로부터 받은 결과<br/>
서버의 json 구조를 정확하게 파악하는 것이 중요하다.<br/>
getNewsModelDetail(@Path() int id) 에서 id는 서버로 전달하는 인자<br/>

