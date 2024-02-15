import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fileupload/core/network/custlog_interceptor.dart';
import 'package:fileupload/core/network/retrofit_url.dart';
import 'package:fileupload/data/provider/base_provider.dart';
import 'package:fileupload/data/repository/rest_client.dart';
import 'package:fileupload/presentation/view/imag_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class FileUploadScreen extends ConsumerStatefulWidget {
  const FileUploadScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FileUploadScreen> createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends ConsumerState<FileUploadScreen> {
  String? _uploadProgress;
  RestClient? _apiService;

  @override
  void initState() {
    super.initState();
    var dio = Dio();
    _apiService = RestClient(dio);
  }

  Future<void> _uploadFile() async {
    final userID = "jsk005";
    final code = "XFD0001";

    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(
      //이미지를 선택
      source: ImageSource.camera, // 위치는 카메라
      maxHeight: 200,
      //maxWidth: 200,
      //imageQuality: 70, // 이미지 크기 압축을 위해 퀄리티를 70으로 낮춤.
    );

    if (pickedImage == null) {
      // No image selected
      return null;
    }

    try {
      // Get the path of the selected image
      String imagePath = pickedImage.path;

      // Create a File object from the image path
      File imageFile = File(imagePath);

      print(imageFile);

      // ref.read(restClientProvider)
      final response = await ref.read(restClientProvider).uploadFile(
        imageFile,
        userID,
        code,
        onSendProgress: (sent, total) {
          setState(() {
            _uploadProgress = "${(sent / total) * 100}%";
          });
        },
      );

      print(response);
      // Return the File object
    } catch (error) {
      // Handle error
      print('Error converting image picker result to File: $error');
      return null;
    }
  }

  Future<void> uploadFile() async {
    final userID = "jsk005";
    final code = "XFD0001";

    final ImagePicker _picker = ImagePicker();

    // Select image from gallery
    XFile? pickedImage = await _picker.pickImage(
      //이미지를 선택
      source: ImageSource.gallery, //위치는 갤러리
      maxHeight: 200,
      //maxWidth: 200,
      //imageQuality: 70, // 이미지 크기 압축을 위해 퀄리티를 70으로 낮춤.
    );

    if (pickedImage != null) {
      try {
        String fileName = pickedImage.path
            .split('/')
            .last; // Extract the file name from its path

        // Create FormData object with the image file
        FormData formData = FormData.fromMap({
          'file': await MultipartFile.fromFile(pickedImage.path,
              filename: fileName),
          "userID": userID,
          "code": code,
        });

        final storage = ref.read(secureStorageProvider);

        // Create Dio instance
        BaseOptions options = BaseOptions(
          baseUrl: RetrofitURL.baseUrl,
        );
        Dio dio = Dio(options);
        dio.interceptors.add(LogInterceptor());
        dio.interceptors.add(
          CustLogInterceptor(storage: storage,),
        );

        // Send POST request with FormData
        final response = await dio.post(
          '${RetrofitURL.baseUrl}${RetrofitURL.imgUpload}',
          data: formData,
          options: Options(
            headers: {
              'Content-Type': 'multipart/form-data',
              // Add any additional headers required by your server
            },
          ),
        );

        final Map<String, dynamic> body = response.data;
        print('${body}');

        // Handle success
        //print('File uploaded successfully');
      } catch (error) {
        // Handle error
        print('Error uploading file: $error');
      }
    }
  }


  /***
   * https://stackoverflow.com/questions/39519773/nsphotolibraryusagedescription-key-must-be-present-in-info-plist-to-use-camera-r
   * info.plist 파일 설정에 관한 사항
   */

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
