import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sunwise_project/app/modules/home/views/home_view.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterSplashScreen.fadeIn(
          backgroundColor: Colors.white,
          duration: Duration(seconds: 2),
          childWidget: SizedBox(
            height: 500,
            width: 500,
            child: Image.asset("assets/images/SunWise.png"),
          ),
          nextScreen: const HomeView(),
        ),
      ),
    );
  }
}
