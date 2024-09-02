import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:image/image.dart' as img;
import 'package:sunwise_project/app/modules/result_screen/views/result_screen_view.dart';
import 'package:sunwise_project/themes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class HomeController extends GetxController {
  var imagePath = ''.obs;
  var estimation = 0.0.obs;
  RxString prediction = ''.obs;
  RxMap responseData = {}.obs;
  RxInt uvValue = 0.obs;
  RxInt humidity = 0.obs;
  RxString errorMessage = ''.obs;
  RxInt temperature = 0.obs;
  RxBool isLoading = false.obs;
  final DatabaseReference _dbRef =
      FirebaseDatabase.instance.ref().child('sensor');

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  void _loadData() {
    isLoading.value = true;
    _dbRef.onValue.listen((event) {
      try {
        final data = event.snapshot.value as Map?;
        if (data != null) {
          humidity.value = (data['humidity'] as num?)?.toInt() ?? 0;
          temperature.value = (data['temperature'] as num?)?.toInt() ?? 0;
          uvValue.value = (data['uvIndex'] as num?)?.toInt() ?? 0;
        }
        isLoading.value = false;
      } catch (e) {
        errorMessage.value = 'Error loading data: $e';
        isLoading.value = false;
      }
    }, onError: (error) {
      errorMessage.value = 'Error: $error';
      isLoading.value = false;
    });
  }

  // open camera and run send data
  Future<void> pickImageFromCamera() async {
    isLoading.value = true;
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      // Konversi gambar ke format PNG
      File pngImage = await _convertToPNG(File(pickedFile.path));
      imagePath.value = pngImage.path;
      // Kirim data segera setelah mengambil gambar
      await sendData(
          pngImage, uvValue.value.toInt()); // Konversi ke integer saat mengirim
    } else {
      isLoading.value = false;
      Get.back();
      print('No image selected.');
    }
  }

  Future<File> _convertToPNG(File imageFile) async {
    return await compute(_convertToPNGIsolate, imageFile.path);
  }

  static File _convertToPNGIsolate(String imagePath) {
    File imageFile = File(imagePath);
    final originalImage = img.decodeImage(imageFile.readAsBytesSync());
    final pngImage = img.encodePng(originalImage!);
    final pngFile = File('${path.withoutExtension(imagePath)}.png');
    pngFile.writeAsBytesSync(pngImage);
    return pngFile;
  }

  Future<File> _compressImage(File file) async {
    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      file.absolute.path.replaceAll('.png', '_compressed.jpg'),
      quality: 88,
    );
    return File(result!.path);
  }

  Future<void> sendData(File imageFile, int uvValue) async {
    final client = http.Client();
    try {
      var url = "https://uvbeneran-j5nhigjovq-uc.a.run.app/predict";
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['uv_index'] = uvValue.toString();

      var compressedFile = await _compressImage(imageFile);
      var length = await compressedFile.length();
      var stream = http.ByteStream(compressedFile.openRead());

      var multipartFile = http.MultipartFile('imagefile', stream, length,
          filename: path.basename(compressedFile.path));
      request.files.add(multipartFile);

      var streamedResponse = await client.send(request);
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        try {
          var jsonData = jsonDecode(response.body);
          estimation.value =
              (jsonData['data']['Estimation'] as num?)?.toDouble() ?? 0.0;
          var estimationString = estimation.value.toStringAsFixed(0);
          prediction.value = ((jsonData['data']['Prediction'] as String?) ?? '')
              .split(' ')
              .first;
          this.responseData.value = jsonData;
          isLoading.value = false;
          Get.to(() => ResultScreenView(), arguments: {
            'estimation': estimationString,
            'prediction': prediction.value,
          });
        } catch (e) {
          print('Error parsing response: $e');
          isLoading.value = false;
        }
      } else {
        print(
            'Error with status code: ${response.statusCode}, response: ${response.body}');
      }
    } catch (e) {
      print('Error sending data: $e');
    } finally {
      client.close();
    }
  }

  // Future<void> sendData(File imageFile, int uvValue) async {
  //   final client = http.Client();
  //   try {
  //     var url = "https://uvbeneran-j5nhigjovq-uc.a.run.app/predict";
  //     var request = http.MultipartRequest('POST', Uri.parse(url));
  //     request.fields['uv_index'] = uvValue.toString();

  //     var compressedFile = await _compressImage(imageFile);
  //     var length = await compressedFile.length();
  //     var stream = http.ByteStream(compressedFile.openRead());

  //     var multipartFile = http.MultipartFile('imagefile', stream, length,
  //         filename: path.basename(compressedFile.path));
  //     request.files.add(multipartFile);

  //     var streamedResponse = await client.send(request);
  //     var response = await http.Response.fromStream(streamedResponse);

  //     if (response.statusCode == 200) {
  //       try {
  //         var responseData = await response.stream.bytesToString();
  //         var jsonData = jsonDecode(responseData);
  //         estimation.value =
  //             (jsonData['data']['Estimation'] as num?)?.toDouble() ?? 0.0;
  //         var estimationString = estimation.value.toStringAsFixed(0);
  //         prediction.value = ((jsonData['data']['Prediction'] as String?) ?? '')
  //             .split(' ')
  //             .first;
  //         this.responseData.value = jsonData;
  //         isLoading.value = false;
  //         Get.to(() => ResultScreenView(), arguments: {
  //           'estimation': estimationString,
  //           'prediction': prediction.value,
  //         });
  //       } catch (e) {
  //         print('Error parsing response: $e');
  //         isLoading.value = false;
  //       }
  //     } else {
  //       print(
  //           'Error with status code: ${response.statusCode}, response: ${response.body}');
  //     }
  //   } catch (e) {
  //     print('Error sending data: $e');
  //   } finally {
  //     client.close();
  //   }
  // }

  // // send data to api
  // Future<void> sendData(File imageFile, int uvValue) async {
  //   var url = "https://uvbeneran-j5nhigjovq-uc.a.run.app/predict";

  //   try {
  //     var request = http.MultipartRequest('POST', Uri.parse(url));
  //     request.fields['uv_index'] = uvValue.toString();
  //     request.files.add(await http.MultipartFile.fromPath(
  //       'imagefile',
  //       imageFile.path,
  //       filename: path
  //           .basename(imageFile.path), // Menggunakan basename dari package path
  //     ));

  //     var response = await request.send();
  //     isLoading.value = true;

  //     if (response.statusCode == 200) {
  //       try {
  //         var responseData = await response.stream.bytesToString();
  //         var jsonData = jsonDecode(responseData);
  //         estimation.value =
  //             (jsonData['data']['Estimation'] as num?)?.toDouble() ?? 0.0;
  //         var estimationString = estimation.value.toStringAsFixed(0);
  //         prediction.value = ((jsonData['data']['Prediction'] as String?) ?? '')
  //             .split(' ')
  //             .first;
  //         this.responseData.value = jsonData;
  //         isLoading.value = false;
  //         Get.to(() => ResultScreenView(), arguments: {
  //           'estimation': estimationString,
  //           'prediction': prediction.value,
  //         });
  //       } catch (e) {
  //         print('Error parsing response: $e');
  //         isLoading.value = false;
  //       }
  //     } else {
  //       // Handle error
  //     }
  //   } catch (e) {
  //     print('Error sending data: $e');
  //   }
  // }

  // get background color according to uv
  Color get progressColor {
    if (uvValue.value <= 4) {
      return safeColor;
    } else if (uvValue.value >= 5 && uvValue.value <= 7) {
      return mediumColor;
    } else if (uvValue.value >= 8) {
      return dangerColor;
    } else {
      return greyColor;
    }
  }

  // get uv text indicator
  String get uvIndicator {
    if (uvValue.value <= 4) {
      return "Indeks UV Rendah";
    } else if (uvValue.value >= 5 && uvValue.value <= 7) {
      return "Indeks UV Menengah";
    } else if (uvValue.value >= 8) {
      return "Indeks UV Tinggi";
    } else {
      return "Tidak ada data";
    }
  }

  // List of skin type characteristics, without recommendations
  final List<Map<String, dynamic>> skinTypes = [
    {
      "type": "I",
      "color": skinType1,
      "typicalFeatures":
          "Very fair skin, white; red or blond hair; light-colored eyes; freckles likely",
      "tanningAbility": "Always burns, does not tan",
      "ethnicity": "Scandinavian, Celtic",
    },
    {
      "type": "II",
      "color": skinType2,
      "typicalFeatures": "Fair skin, white; light eyes; light hair",
      "tanningAbility": "Burns easily, tans poorly",
      "ethnicity": "Northern European (Caucasian)",
    },
    {
      "type": "III",
      "color": skinType3,
      "typicalFeatures":
          "Fair skin, cream white; any eye or hair color (very common skin type)",
      "tanningAbility": "Tans after initial burn",
      "ethnicity": "Darker Caucasian (Central Europe)",
    },
    {
      "type": "IV",
      "color": skinType4,
      "typicalFeatures":
          "Olive skin, typical Mediterranean Caucasian skin; dark brown hair; medium to heavy pigmentation",
      "tanningAbility": "Burns minimally, tans easily",
      "ethnicity": "Mediterranean, Asian, Hispanic",
    },
    {
      "type": "V",
      "color": skinType5,
      "typicalFeatures":
          "Brown skin, typical Middle Eastern skin; dark hair; rarely sun sensitive",
      "tanningAbility": "Rarely burns, tans darkly easily",
      "ethnicity":
          "Middle Eastern, Latin, light-skinned African-American, Indian",
    },
    {
      "type": "VI",
      "color": skinType6,
      "typicalFeatures": "Black skin; rarely sun sensitive",
      "tanningAbility": "Never burns, always tans darkly",
      "ethnicity": "Dark-skinned African American",
    },
  ];
}
