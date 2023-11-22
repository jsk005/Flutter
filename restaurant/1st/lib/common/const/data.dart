import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

final storage = FlutterSecureStorage();

final emulatorIp = '10.0.2.2:3000';
final simulatorIp = '127.0.0.1:3000';
final realIp = ''; // 실제 서버 IP주소 및 포트번호는 삭제 처리함.
