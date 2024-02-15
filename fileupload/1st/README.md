#### 실행 방법
프로젝트를 생성 시 프로젝트명을 동일하게 하면 그대로 동작하는 걸 확인할 수 있다.<br/>
pubspec.yaml 파일에서 dependencies 와 dev_dependencies 에 추가한 것을 참조하여 추가한다.<br/>
lib 폴더를 그대로 덮어쓰기 한다.<br/>
ios 폴더의 Info.plist 를 참조하여 추가한다.<br/>
```
<key>NSPhotoLibraryUsageDescription</key>
<string>This app requires access to the photo library.</string>
<key>NSCameraUsageDescription</key>
<string>This app requires access to the camera.</string>
<key>NSMicrophoneUsageDescription</key>
<string>This app does not require access to the microphone.</string>
```
Android app 폴더의 build.gradle 수정사항은 컴파일 하면 image_picker 버전에 따라 요구버전이 다를 것이다.<br/>
compileSdkVersion 34<br/>
minSdkVersion 23<br/>

#### Retrofit 라이브러리 활용
riverpod 상태관리를 사용하지 않을 경우에는 <br/>
final response = await ref.read(restClientProvider).uploadFile 코드를 <br/>
final response = await _apiService!.uploadFile 로 변경해서 사용하면 된다. <br/>


#### PHP 샘플코드
SQL 테이블 구조와 PHP 샘플코드는 PHP 폴더에 포함되어 있으니 참고하면 도움될 것이다.