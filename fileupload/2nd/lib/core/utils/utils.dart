import 'package:flutter/material.dart';

class Utils {
  static Future<void> showAlert(
      BuildContext context, String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        textAlign: TextAlign.center,
      ),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.blue,
    ));
  }

  // 휴대폰 번호 추출 시 앞의 문자열 치환
  static String getPhoneNumber(String phoneNumber) {
    if (phoneNumber.startsWith("82+82")) {
      phoneNumber = phoneNumber.replaceAll("82+82", "0");
    }
    return phoneNumber.replaceAll("-", "");
  }

  // 전화번호 하이픈 자동 표시
  static String displayPhoneNumber(String phoneNumber){
    if(phoneNumber.startsWith("02")) {
      phoneNumber = phoneNumber.replaceAllMapped(RegExp(r'(\d{2})(\d{3,4})(\d{4})'), (m) => '${m[1]}-${m[2]}-${m[3]}');
    } else {
      phoneNumber = phoneNumber.replaceAllMapped(RegExp(r'(\d{3})(\d{3,4})(\d{4})'), (m) => '${m[1]}-${m[2]}-${m[3]}');
    }
    return phoneNumber;
  }

}
