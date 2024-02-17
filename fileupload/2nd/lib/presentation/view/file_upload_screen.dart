import 'dart:io';

import 'package:dio/dio.dart';
import 'package:exif/exif.dart';
import 'package:fileupload/core/network/custlog_interceptor.dart';
import 'package:fileupload/core/network/retrofit_url.dart';
import 'package:fileupload/core/utils/utils.dart';
import 'package:fileupload/data/provider/base_provider.dart';
import 'package:fileupload/data/repository/rest_client.dart';
import 'package:fileupload/domain/models/image_model.dart';
import 'package:fileupload/domain/models/location.dart';
import 'package:fileupload/presentation/component/location_service.dart';
import 'package:fileupload/presentation/view/imag_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class FileUploadScreen extends ConsumerStatefulWidget {
  const FileUploadScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FileUploadScreen> createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends ConsumerState<FileUploadScreen> {
  final locationService = LocationService();
  Location imgLocation = Location(latitude: 0, longitude: 0);

  String? _uploadProgress;

  @override
  void initState() {
    super.initState();
    locationService.locationPermission();
  }

  Future<void> _uploadFile() async {
    final userID = "jsk005";
    final code = "XFD0001";

    final ImagePicker picker = ImagePicker();
    final XFile? pickerImage = await picker.pickImage(
      //이미지를 선택
      source: ImageSource.camera, // 위치는 카메라
      maxHeight: 200,
      //maxWidth: 200,
      //imageQuality: 70, // 이미지 크기 압축을 위해 퀄리티를 70으로 낮춤.
    );

    if (pickerImage != null) {
      // 사진 이미지에서 위치좌표 정보 추출. 사진에 위치좌표 정보가 없으면 현재 GPS 정보로 대체
      String imagePath = pickerImage.path; // Get the path of the selected image
      imgLocation = await locationService.getImageLocationInfo(imagePath);

      File imageFile =
          File(imagePath); // Create a File object from the image path
      //print(imageFile);

      ImageModel response = await ref.read(restClientProvider).uploadFile(
        imageFile,
        userID,
        code,
        imgLocation.latitude,
        imgLocation.longitude,
        onSendProgress: (sent, total) {
          setState(() {
            _uploadProgress = "${(sent / total) * 100}%";
          });
        },
      );

      //print(response); // Retrofit 반환결과가 String 타입이면 메시지 내용 확인 가능

      if (response.result.contains('success')) {
        Utils.showAlert(context, response.result, '서버에 성공적으로 저장되었습니다.');
      } else {
        Utils.showAlert(context, response.result, response.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _uploadFile,
              child: Text("Upload File"),
            ),
            if (_uploadProgress != null)
              Text("Upload Progress: $_uploadProgress"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ImageViewScreen(),
          ));
        },
        tooltip: 'scan',
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
