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

class HomeController extends GetxController {
  var imagePath = ''.obs;
  var estimation = 0.0.obs;
  RxString prediction = ''.obs;
  RxMap responseData = {}.obs;
  RxInt uvValue = 0.obs;
  RxInt humidity = 0.obs;
  RxInt temperature = 0.obs;
  RxBool isLoading = false.obs;
  final DatabaseReference _dbRef =
      FirebaseDatabase.instance.ref().child('sensor');

  // get real time data from IOT device
  @override
  void onInit() {
    super.onInit();
    _dbRef.onValue.listen((event) {
      var snapshotValue = event.snapshot.value;
      if (snapshotValue != null && snapshotValue is Map) {
        var data = snapshotValue as Map;
        if (data.containsKey('humidity') && data['humidity'] is num) {
          humidity.value = data['humidity'].toInt();
          print(humidity);
        }
        if (data.containsKey('temperature') && data['temperature'] is num) {
          temperature.value = data['temperature'].toInt();
          print(temperature);
        }
        if (data.containsKey('uvIndex') && data['uvIndex'] is num) {
          uvValue.value = data['uvIndex'].toInt();
          print(uvValue);
        }
      }
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

  // convert to PNG
  Future<File> _convertToPNG(File imageFile) async {
    final originalImage = img.decodeImage(imageFile.readAsBytesSync());
    final pngImage = img.encodePng(originalImage!);
    final pngFile = File('${path.withoutExtension(imageFile.path)}.png');
    await pngFile.writeAsBytes(pngImage);
    return pngFile;
  }

  // send data to api
  Future<void> sendData(File imageFile, int uvValue) async {
    var url = "https://uvbeneran-j5nhigjovq-uc.a.run.app/predict";

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['uv_index'] = uvValue.toString();
      request.files.add(await http.MultipartFile.fromPath(
        'imagefile',
        imageFile.path,
        filename: path
            .basename(imageFile.path), // Menggunakan basename dari package path
      ));

      var response = await request.send();
      isLoading.value = true;
      // Setelah mendapatkan respons dari API
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var jsonData = jsonDecode(responseData);
        estimation.value = (jsonData['data']['Estimation']);
        // Ubah ke String dan hilangkan bagian desimal
        var estimationString = estimation.value.toStringAsFixed(0);
        // trim the text
        prediction.value = (jsonData['data']['Prediction']).toString();
        List<String> predictionParts = prediction.split(' ');
        prediction.value = predictionParts[0];
        this.responseData.value =
            jsonData; // Setel variabel responseData dengan respons data
        isLoading.value = false;
        Get.to(() => ResultScreenView(), arguments: {
          'estimation': estimationString,
          'prediction': prediction.value,
        });
        print('Response data: $jsonData');
      } else {
        var responseData = await response.stream.bytesToString();
        print(
            'Error with status code: ${response.statusCode}, response: $responseData');
      }
    } catch (e) {
      print('Error sending data: $e');
    }
  }

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
