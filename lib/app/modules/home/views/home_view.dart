import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sunwise_project/app/modules/chat_screen/views/chat_screen_view.dart';
import 'package:sunwise_project/app/modules/home/widget/SkinTypeTile.dart';
import 'package:sunwise_project/themes.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());

    // return Scaffold(
    //   backgroundColor: controller.progressColor,
    //   body: SafeArea(
    //     child: Obx(() {
    //       if (controller.isLoading.value) {
    //         return Center(child: CircularProgressIndicator());
    //       } else {
    //         return Padding(
    //           padding: const EdgeInsets.only(left: 33, right: 33),
    //           child: ListView(
    //             children: [
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Text("${controller.uvValue.value}",
    //                       style: regulerText170),
    //                   Column(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     crossAxisAlignment: CrossAxisAlignment.end,
    //                     children: [
    //                       Row(
    //                         children: [
    //                           Text("${controller.humidity.value}",
    //                               style: regulerText20),
    //                           SizedBox(width: 3),
    //                           FaIcon(FontAwesomeIcons.droplet, size: 19)
    //                         ],
    //                       ),
    //                       SizedBox(height: 70),
    //                       Text("${controller.temperature.value} \u2103",
    //                           style: regulerText20),
    //                     ],
    //                   )
    //                 ],
    //               ),
    //               Text("Indeks UV", style: regulerText40),
    //               Text("Kukusan, Depok", style: regulerText24),
    //               SizedBox(height: 13),
    //               Row(
    //                 children: [
    //                   Container(
    //                     decoration: BoxDecoration(
    //                       color: whiteColor,
    //                       borderRadius: BorderRadius.circular(12),
    //                     ),
    //                     child: Padding(
    //                       padding: const EdgeInsets.all(8),
    //                       child: Obx(() => Text(controller.uvIndicator,
    //                           style: regulerText17)),
    //                     ),
    //                   ),
    //                   SizedBox(width: 10),
    //                   Obx(() => IgnorePointer(
    //                         ignoring: controller.isLoading.value ? true : false,
    //                         child: GestureDetector(
    //                           onTap: () => controller.pickImageFromCamera(),
    //                           child: Container(
    //                             decoration: BoxDecoration(
    //                               color: whiteColor,
    //                               borderRadius: BorderRadius.circular(12),
    //                             ),
    //                             child: Padding(
    //                               padding: const EdgeInsets.all(8.0),
    //                               child: Obx(() {
    //                                 if (controller.isLoading.value)
    //                                   return Container(
    //                                     width: 18,
    //                                     height: 18,
    //                                     child: CircularProgressIndicator(
    //                                         strokeWidth: 2),
    //                                   );
    //                                 else {
    //                                   return FaIcon(
    //                                       size: 18, FontAwesomeIcons.expand);
    //                                 }
    //                               }),
    //                             ),
    //                           ),
    //                         ),
    //                       )),
    //                 ],
    //               ),
    //               SizedBox(height: 32),
    //               Text("Klik kulit kamu!", style: regulerText24),
    //               SizedBox(height: 13),
    //               Container(
    //                 width: 400,
    //                 height: 150,
    //                 decoration: BoxDecoration(
    //                   color: whiteColor,
    //                   borderRadius: BorderRadius.circular(12),
    //                 ),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                   children: [
    //                     SkinTypeTile(
    //                       color: skinType1,
    //                       type: "I",
    //                       typicalFeatures:
    //                           "Kulit sangat terang, putih; rambut merah atau pirang; mata berwarna terang; kemungkinan berbintik",
    //                       tanningAbility:
    //                           "Selalu terbakar, tidak bisa berjemur",
    //                       ethnicity: "Skandinavia, Celtic",
    //                     ),
    //                     VerticalDivider(
    //                       thickness: 0.8,
    //                       indent: 50,
    //                       endIndent: 50,
    //                       color: blackColor,
    //                     ),
    //                     SkinTypeTile(
    //                       color: skinType2,
    //                       type: "II",
    //                       typicalFeatures:
    //                           "Kulit terang, putih; mata terang; rambut terang",
    //                       tanningAbility: "Mudah terbakar, sulit berjemur",
    //                       ethnicity: "Eropa Utara (Kaukasia)",
    //                     ),
    //                     VerticalDivider(
    //                       thickness: 0.8,
    //                       indent: 50,
    //                       endIndent: 50,
    //                       color: blackColor,
    //                     ),
    //                     SkinTypeTile(
    //                       color: skinType3,
    //                       type: "III",
    //                       typicalFeatures:
    //                           "Kulit terang, putih krem; warna mata atau rambut apa saja (jenis kulit yang sangat umum)",
    //                       tanningAbility: "Berjemur setelah terbakar awal",
    //                       ethnicity: "Kaukasia lebih gelap (Eropa Tengah)",
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               SizedBox(height: 30),
    //               Container(
    //                 width: 400,
    //                 height: 150,
    //                 decoration: BoxDecoration(
    //                   color: whiteColor,
    //                   borderRadius: BorderRadius.circular(12),
    //                 ),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                   children: [
    //                     SkinTypeTile(
    //                       color: skinType4,
    //                       type: "IV",
    //                       typicalFeatures:
    //                           "Kulit zaitun, kulit khas Kaukasia Mediterania; rambut coklat tua; pigmentasi sedang hingga berat",
    //                       tanningAbility: "Jarang terbakar, mudah berjemur",
    //                       ethnicity: "Mediterania, Asia, Hispanik",
    //                     ),
    //                     VerticalDivider(
    //                       thickness: 0.8,
    //                       indent: 50,
    //                       endIndent: 50,
    //                       color: blackColor,
    //                     ),
    //                     SkinTypeTile(
    //                       color: skinType5,
    //                       type: "V",
    //                       typicalFeatures:
    //                           "Kulit coklat, kulit khas Timur Tengah; rambut gelap; jarang sensitif terhadap matahari",
    //                       tanningAbility:
    //                           "Jarang terbakar, mudah berjemur menjadi gelap",
    //                       ethnicity:
    //                           "Timur Tengah, Latin, Afrika-Amerika berkulit terang, India",
    //                     ),
    //                     VerticalDivider(
    //                       thickness: 0.8,
    //                       indent: 50,
    //                       endIndent: 50,
    //                       color: blackColor,
    //                     ),
    //                     SkinTypeTile(
    //                       color: skinType6,
    //                       type: "VI",
    //                       typicalFeatures:
    //                           "Kulit hitam; jarang sensitif terhadap matahari",
    //                       tanningAbility:
    //                           "Tidak pernah terbakar, selalu berjemur menjadi sangat gelap",
    //                       ethnicity: "Afrika-Amerika berkulit gelap",
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               SizedBox(height: 20),
    //               Padding(
    //                 padding: const EdgeInsets.symmetric(vertical: 30),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.end,
    //                   children: [
    //                     Container(
    //                       height: 70,
    //                       width: 70,
    //                       decoration: BoxDecoration(
    //                         color: blackColor,
    //                         borderRadius: BorderRadius.all(Radius.circular(35)),
    //                       ),
    //                       child: Center(
    //                           child: IconButton(
    //                         onPressed: () {
    //                           Get.to(ChatScreenView());
    //                         },
    //                         icon: FaIcon(
    //                           FontAwesomeIcons.message,
    //                           color: accentColor,
    //                           size: 25,
    //                         ),
    //                       )),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         );
    //       }
    //     }),
    //   ),
    // );

    return Scaffold(
      // backgroundColor: controller.progressColor,
      body: SafeArea(
          child: Stack(
        children: [
          Obx(() =>
              Expanded(child: Container(color: controller.progressColor))),
          Padding(
            padding: const EdgeInsets.only(left: 33, right: 33),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => Text("${controller.uvValue.value}",
                        style: regulerText170)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Obx(() => Text("${controller.humidity.value}",
                                style: regulerText20)),
                            SizedBox(width: 3),
                            FaIcon(FontAwesomeIcons.droplet, size: 19)
                          ],
                        ),
                        SizedBox(height: 70),
                        Obx(() => Text("${controller.temperature.value} \u2103",
                            style: regulerText20)),
                      ],
                    )
                  ],
                ),
                Text("Indeks UV", style: regulerText40),
                Text("Kukusan, Depok", style: regulerText24),
                SizedBox(height: 13),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Obx(() =>
                            Text(controller.uvIndicator, style: regulerText17)),
                      ),
                    ),
                    SizedBox(width: 10),
                    Obx(() => IgnorePointer(
                          ignoring: controller.isLoading.value ? true : false,
                          child: GestureDetector(
                            onTap: () => controller.pickImageFromCamera(),
                            child: Container(
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Obx(() {
                                  if (controller.isLoading.value)
                                    return Container(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2),
                                    );
                                  else {
                                    return FaIcon(
                                        size: 18, FontAwesomeIcons.expand);
                                  }
                                }),
                                // FaIcon(size: 18, FontAwesomeIcons.expand),
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
                SizedBox(height: 32),
                Text("Klik kulit kamu!", style: regulerText24),
                SizedBox(height: 13),
                Container(
                  width: 400,
                  height: 150,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SkinTypeTile(
                        color: skinType1,
                        type: "I",
                        typicalFeatures:
                            "Kulit sangat terang, putih; rambut merah atau pirang; mata berwarna terang; kemungkinan berbintik",
                        tanningAbility: "Selalu terbakar, tidak bisa berjemur",
                        ethnicity: "Skandinavia, Celtic",
                      ),
                      VerticalDivider(
                        thickness: 0.8,
                        indent: 50,
                        endIndent: 50,
                        color: blackColor,
                      ),
                      SkinTypeTile(
                        color: skinType2,
                        type: "II",
                        typicalFeatures:
                            "Kulit terang, putih; mata terang; rambut terang",
                        tanningAbility: "Mudah terbakar, sulit berjemur",
                        ethnicity: "Eropa Utara (Kaukasia)",
                      ),
                      VerticalDivider(
                        thickness: 0.8,
                        indent: 50,
                        endIndent: 50,
                        color: blackColor,
                      ),
                      SkinTypeTile(
                        color: skinType3,
                        type: "III",
                        typicalFeatures:
                            "Kulit terang, putih krem; warna mata atau rambut apa saja (jenis kulit yang sangat umum)",
                        tanningAbility: "Berjemur setelah terbakar awal",
                        ethnicity: "Kaukasia lebih gelap (Eropa Tengah)",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: 400,
                  height: 150,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SkinTypeTile(
                        color: skinType4,
                        type: "IV",
                        typicalFeatures:
                            "Kulit zaitun, kulit khas Kaukasia Mediterania; rambut coklat tua; pigmentasi sedang hingga berat",
                        tanningAbility: "Jarang terbakar, mudah berjemur",
                        ethnicity: "Mediterania, Asia, Hispanik",
                      ),
                      VerticalDivider(
                        thickness: 0.8,
                        indent: 50,
                        endIndent: 50,
                        color: blackColor,
                      ),
                      SkinTypeTile(
                        color: skinType5,
                        type: "V",
                        typicalFeatures:
                            "Kulit coklat, kulit khas Timur Tengah; rambut gelap; jarang sensitif terhadap matahari",
                        tanningAbility:
                            "Jarang terbakar, mudah berjemur menjadi gelap",
                        ethnicity:
                            "Timur Tengah, Latin, Afrika-Amerika berkulit terang, India",
                      ),
                      VerticalDivider(
                        thickness: 0.8,
                        indent: 50,
                        endIndent: 50,
                        color: blackColor,
                      ),
                      SkinTypeTile(
                        color: skinType6,
                        type: "VI",
                        typicalFeatures:
                            "Kulit hitam; jarang sensitif terhadap matahari",
                        tanningAbility:
                            "Tidak pernah terbakar, selalu berjemur menjadi sangat gelap",
                        ethnicity: "Afrika-Amerika berkulit gelap",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: blackColor,
                          borderRadius: BorderRadius.all(Radius.circular(35)),
                        ),
                        child: Center(
                            child: IconButton(
                          onPressed: () {
                            Get.to(ChatScreenView());
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.message,
                            color: accentColor,
                            size: 25,
                          ),
                        )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
