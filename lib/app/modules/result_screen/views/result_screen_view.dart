import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:sunwise_project/app/modules/home/controllers/home_controller.dart';
import 'package:sunwise_project/themes.dart';

import '../controllers/result_screen_controller.dart';

class ResultScreenView extends GetView<ResultScreenController> {
  const ResultScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(ResultScreenController());
    final HomeController homeController = Get.put(HomeController());

    final Map<String, dynamic> arguments = Get.arguments;
    final String prediction = arguments['prediction'];
    final String estimation = arguments['estimation'];

    // Get the characteristics from the controller
    final String characteristics = controller.getCharacteristics(prediction);
    // Get the color from the controller
    final Color skinColor = controller.getColorForPrediction(prediction);
    // Get the recommendation from the controller
    final Map<String, String> recommendations =
        controller.getRecommendations(prediction);

    // using home controller
    return Scaffold(
        backgroundColor: homeController.progressColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 200,
                        height: 60,
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12),
                                bottomRight: Radius.circular(12))),
                        child: Center(
                            child: Text("rekomendasi", style: regulerText24)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 6),
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      color: whiteColor,
                                      borderRadius: BorderRadius.circular(35)),
                                  child: Center(
                                      child: FaIcon(FontAwesomeIcons.redhat,
                                          size: 35)),
                                ),
                                SizedBox(width: 6),
                                Flexible(
                                  child: Text(recommendations["hat"]!,
                                      style: regulerText20),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 6),
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      color: whiteColor,
                                      borderRadius: BorderRadius.circular(35)),
                                  child: Center(
                                      child: FaIcon(FontAwesomeIcons.handDots,
                                          size: 35)),
                                ),
                                SizedBox(width: 6),
                                Flexible(
                                  child: Text(recommendations["lotion"]!,
                                      style: regulerText20),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 6),
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      color: whiteColor,
                                      borderRadius: BorderRadius.circular(35)),
                                  child: Center(
                                      child: FaIcon(FontAwesomeIcons.shirt,
                                          size: 35)),
                                ),
                                SizedBox(width: 6),
                                Flexible(
                                  child: Text(recommendations["clothing"]!,
                                      style: regulerText20),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Tipe Kulit $prediction",
                                style: regulerText20),
                            SizedBox(height: 8),
                            Container(
                              padding: EdgeInsets.all(12),
                              height: 100,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(characteristics,
                                        style: regulerText13),
                                  ),
                                  Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        color: skinColor,
                                        borderRadius:
                                            BorderRadius.circular(35)),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Estimasi", style: regulerText20),
                            SizedBox(height: 8),
                            Container(
                              padding: EdgeInsets.all(12),
                              height: 100,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                        "$estimation menit sebelum kulit terbakar matahari",
                                        style: regulerText17),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              style: ButtonStyle(
                                  padding: WidgetStateProperty.all(
                                      EdgeInsets.all(20)),
                                  shape:
                                      WidgetStateProperty.all(CircleBorder()),
                                  backgroundColor:
                                      WidgetStateProperty.all(blackColor)),
                              onPressed: () {
                                Get.back();
                              },
                              icon: FaIcon(
                                FontAwesomeIcons.angleRight,
                                color: accentColor,
                                size: 35,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
