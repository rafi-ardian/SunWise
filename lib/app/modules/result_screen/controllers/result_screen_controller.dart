import 'dart:ui';

import 'package:get/get.dart';
import 'package:sunwise_project/themes.dart';

class ResultScreenController extends GetxController {
  final List<Map<String, dynamic>> skinTypes = [
    {
      "type": "I",
      "characteristics":
          "Kulit sangat terang atau pucat, rambut merah atau pirang, mata biru atau hijau",
      "recommendations": {
        "hat": "Topi bertepi lebar dengan perlindungan UV",
        "lotion": "Tabir surya SPF 30+",
        "clothing": "Kemeja dan celana lengan panjang yang ringan"
      }
    },
    {
      "type": "II",
      "characteristics":
          "Kulit terang, rambut pirang atau cokelat muda, mata biru, hijau, atau cokelat muda",
      "recommendations": {
        "hat": "Topi bertepi lebar dengan perlindungan UV",
        "lotion": "Tabir surya SPF 30+",
        "clothing": "Kemeja dan celana lengan panjang yang ringan"
      }
    },
    {
      "type": "III",
      "characteristics":
          "Kulit terang hingga beige, rambut cokelat, mata cokelat atau hazel",
      "recommendations": {
        "hat": "Topi bertepi lebar dengan perlindungan UV",
        "lotion": "Tabir surya SPF 15+",
        "clothing": "Kemeja dan celana lengan panjang yang ringan"
      }
    },
    {
      "type": "IV",
      "characteristics":
          "Kulit cokelat muda atau zaitun, rambut cokelat tua, mata cokelat",
      "recommendations": {
        "hat": "Topi bertepi lebar dengan perlindungan UV",
        "lotion": "Tabir surya SPF 15+",
        "clothing": "Kemeja dan celana lengan panjang yang ringan"
      }
    },
    {
      "type": "V",
      "characteristics":
          "Kulit cokelat, rambut cokelat tua atau hitam, mata cokelat tua",
      "recommendations": {
        "hat": "Topi bertepi lebar dengan perlindungan UV",
        "lotion": "Tabir surya SPF 15+",
        "clothing": "Kemeja dan celana lengan panjang yang ringan"
      }
    },
    {
      "type": "VI",
      "characteristics":
          "Kulit cokelat tua atau hitam, rambut hitam, mata cokelat tua",
      "recommendations": {
        "hat": "Opsional, tergantung pada preferensi pribadi",
        "lotion": "Tabir surya SPF 15+",
        "clothing": "Pakaian ringan"
      }
    },
  ];

  // Define a map of skin colors based on types
  final Map<String, Color> skinColors = {
    "I": skinType1,
    "II": skinType2,
    "III": skinType3,
    "IV": skinType4,
    "V": skinType5,
    "VI": skinType6,
    // Add more colors as needed for other types
  };

  // Method to get characteristics based on prediction
  String getCharacteristics(String prediction) {
    final skinType = skinTypes.firstWhere(
      (type) => type["type"] == prediction,
      orElse: () => {"type": "Unknown", "characteristics": "Unknown skin type"},
    );
    return skinType["characteristics"]!;
  }

  // Method to get color based on prediction
  Color getColorForPrediction(String prediction) {
    return skinColors[prediction] ??
        greyColor; // Default to grey if prediction doesn't match
  }

  // Method to get recommendations based on prediction
  Map<String, String> getRecommendations(String prediction) {
    final skinType = skinTypes.firstWhere(
      (type) => type["type"] == prediction,
      orElse: () => {
        "recommendations": {
          "hat": "No recommendations available",
          "lotion": "No recommendations available",
          "clothing": "No recommendations available"
        }
      },
    );
    return Map<String, String>.from(skinType["recommendations"]);
  }
}
