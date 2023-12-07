import 'dart:convert';
import 'package:rest/common/const/data.dart';

class DataUtils {
  static String pathToUrl(String value){
    return 'http://$realIp$value';
  }

  static DateTime stringToDateTime(String value){
    return DateTime.parse(value);
  }

  static List<String> listPathsToUrls(List paths){
    return paths.map((e) => pathToUrl(e)).toList();
  }

  static String plainToBase64(String plain){
    Codec<String, String> stringToBase64 = utf8.fuse(base64);

    String encoded = stringToBase64.encode(plain);

    return encoded;
  }

}