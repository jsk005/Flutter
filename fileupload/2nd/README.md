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
<key>NSLocationWhenInUseUsageDescription</key>
<string>사용자의 현재 위치를 기반으로 날씨나 장소정보를 제공하기 위해 필요한 권한입니다.</string>
<key>NSLocationUsageDescription</key>
<string>오래된 기종 위치 정보에 필요합니다.</string>
```
Android root 폴더의 build.gradle 수정사항은 ext.kotlin_version = '1.9.22' 로 변경해야 컴파일에 문제가 없더라.<br/>
Android app 폴더의 build.gradle 수정사항은 컴파일 하면 image_picker 버전에 따라 요구버전이 다를 것이다.<br/>
compileSdkVersion 34<br/>
minSdkVersion 23<br/>

#### Retrofit 라이브러리 활용
riverpod 상태관리를 사용하지 않을 경우에는 <br/>
final response = await ref.read(restClientProvider).uploadFile 코드를 <br/>
final response = await _apiService!.uploadFile 로 변경해서 사용하면 된다. <br/>
1st 버전을 참고해서 빠진 코드를 찾아서 추가해야 한다.<br/>

#### 사진 이미지에서 위치좌표 추출 코드
```
  Future<Location> getExifLocationData(var data) async {
    if (data.containsKey('GPS GPSLongitude')) {
      final gpsLatitude = data['GPS GPSLatitude'];
      final latitudeSignal = data['GPS GPSLatitudeRef']!.printable;
      List latitudeRation = gpsLatitude!.values.toList();
      List latitudeValue = latitudeRation.map((item) {
        return (item.numerator.toDouble() / item.denominator.toDouble());
      }).toList();
      _latitude = latitudeValue[0] +
          (latitudeValue[1] / 60) +
          (latitudeValue[2] / 3600);
      if (latitudeSignal == 'S') _latitude = -_latitude;
      print('latitude ::: ${_latitude}');

      final gpsLongitude = data['GPS GPSLongitude'];
      final longitudeSignal = data['GPS GPSLongitude']!.printable;
      List longitudeRation = gpsLongitude!.values.toList();
      List longitudeValue = longitudeRation.map((item) {
        return (item.numerator.toDouble() / item.denominator.toDouble());
      }).toList();
      _longitude = longitudeValue[0] +
          (longitudeValue[1] / 60) +
          (longitudeValue[2] / 3600);
      if (longitudeSignal == 'W') _longitude = -_longitude;
      print('longitude ::: ${_longitude}');

      return Location(latitude: _latitude, longitude: _longitude);
    }
    return Location(latitude: _latitude, longitude: _longitude);
  }
```

#### PHP 샘플코드
SQL 테이블 구조와 PHP 샘플코드는 PHP 폴더에 포함되어 있으니 참고하면 도움될 것이다.<br/>

```
CREATE TABLE photo_data (
  idx int(11) NOT NULL,
  code varchar(20) NOT NULL COMMENT '코드',
  userID varchar(20) NOT NULL,
  realname varchar(100) NOT NULL DEFAULT '0' COMMENT '실업로드파일명',
  filename varchar(100) NOT NULL DEFAULT '0' COMMENT '변경저장파일명',
  lat float(9,6) NOT NULL DEFAULT 0.000000 COMMENT '위도',
  lng float(9,6) NOT NULL DEFAULT 0.000000 COMMENT '경도',
  reg_date timestamp NULL DEFAULT NULL COMMENT '업로드일자',
  removed int(1) NOT NULL DEFAULT -1,
  display tinyint(2) NOT NULL DEFAULT 1
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

ALTER TABLE photo_data
  ADD PRIMARY KEY (idx),
  ADD KEY code (code);

ALTER TABLE photo_data
  MODIFY idx int(11) NOT NULL AUTO_INCREMENT;
COMMIT;
```