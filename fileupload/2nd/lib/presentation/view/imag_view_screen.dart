import 'dart:io';

import 'package:fileupload/domain/models/location.dart';
import 'package:fileupload/presentation/component/location_service.dart';
import 'package:fileupload/presentation/view/file_upload_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageViewScreen extends StatefulWidget {
  const ImageViewScreen({super.key});

  @override
  State<ImageViewScreen> createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen> {
  final locationService = LocationService();
  Location imgLocation = Location(latitude: 0, longitude: 0);

  XFile? _image; //이미지 담을 변수 선언

  @override
  void initState() {
    super.initState();
    locationService.locationPermission();
  }

  Future<void> getImage(ImageSource imageSource) async {
    var picker = ImagePicker();
    var pickerImage = await picker.pickImage(source: imageSource);

    if (pickerImage != null) {
      imgLocation = await locationService.getImageLocationInfo(pickerImage.path);

      // 이미지를 출력하기 위해 상태 변경
      setState(() {
        _image = XFile(pickerImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPhotoArea(),
          if(imgLocation.latitude > 0) _buildLocation(),
        ],
      ),
      floatingActionButton: Stack(
        children: [
          Align(
            alignment: Alignment(
                Alignment.bottomRight.x, Alignment.bottomRight.y - 0.4),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const FileUploadScreen(),
                ));
              },
              tooltip: 'back',
              heroTag: UniqueKey(),
              child: const Icon(Icons.arrow_back),
            ),
          ),
          Align(
            alignment: Alignment(
                Alignment.bottomRight.x, Alignment.bottomRight.y - 0.2),
            child: FloatingActionButton(
              onPressed: () async {
                getImage(ImageSource.camera);
              },
              tooltip: 'image',
              heroTag: UniqueKey(),
              child: const Icon(Icons.camera_alt),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () async {
                getImage(ImageSource.gallery);
              },
              tooltip: 'image',
              heroTag: UniqueKey(),
              child: const Icon(Icons.image),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoArea() {
    return _image != null
        ? Container(
            width: 400,
            height: 400,
            child: Image.file(File(_image!.path)), //가져온 이미지 화면에 띄워주는 코드
          )
        : const Center(
            child: Text("불러온 이미지가 없습니다."),
          );
  }

  Widget _buildLocation() {
    return Column(
      children: [
        Container(
          child: Text('GPS Location ::: ${imgLocation.isLocation}'),
        ),
        Container(
          child: Text('위도: ${imgLocation.latitude} ,경도: ${imgLocation.longitude}'),
        ),
      ],
    );
  }

}
