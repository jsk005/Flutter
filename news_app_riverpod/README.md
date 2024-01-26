### 개요
News APP은 Android 버전도 샘플로 많이 구현되어 있을 정도로 유명한 사이트 자료를 가져와서 구현하는 방법을 다루는 예제이다.<br/>
Flutter 버전으로 구현을 해보면서 벽에 부딪친 사항과 이를 해결하는 과정을 기록해두려고 하다보니 sub 폴더를 구성하게 되었다.

### Getting Started
Clean Architecture 구조를 지향하여 디렉토리 구조는 최대한 준용하려고 했다.<br/>
NewsDataResult.fromJson 부분 구현이 핵심사항이다. 이 부분을 잘못 구현하면 에러가 발생한다.<br/>
서버 데이터 구조가 Null 을 허용하는 변수인지 아닌지 여부 파악이 쉽지 않다.<br/>
compile 할 때 에러가 발생하면 Retrofit 라이브러리가 제대로 동작되지 않는다. Model Class 정의한 변수를 하나씩 nullable로 변경하면서 테스트해야 한다.<br/>

### 세부 내용
세부 설명은 하위 폴더에 있는 Readme 를 읽어보면 된다.
