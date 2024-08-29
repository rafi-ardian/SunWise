import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SkinTypeTile extends StatelessWidget {
  final Color color;
  final String type;
  final String typicalFeatures;
  final String tanningAbility;
  final String ethnicity;

  const SkinTypeTile({
    Key? key,
    required this.color,
    required this.type,
    required this.typicalFeatures,
    required this.tanningAbility,
    required this.ethnicity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.dialog(
          useSafeArea: true,
          Dialog(
            child: Container(
              height: 400,
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Stack(
                children: [
                  Positioned(
                      right: 5,
                      top: 5,
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: FaIcon(FontAwesomeIcons.xmark, size: 25),
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("tipe: $type",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text("Warna:", style: TextStyle(fontSize: 16)),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text("Ciri Khas: $typicalFeatures",
                          style: TextStyle(fontSize: 16)),
                      SizedBox(height: 8),
                      Text("Kemampuan Berjemur: $tanningAbility",
                          style: TextStyle(fontSize: 16)),
                      SizedBox(height: 8),
                      Text("Etnisitas: $ethnicity",
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(35),
            ),
          ),
          SizedBox(height: 6),
          Text("Tipe $type", style: TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}
