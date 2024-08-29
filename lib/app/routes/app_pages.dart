import 'package:get/get.dart';

import 'package:sunwise_project/app/modules/chat_screen/bindings/chat_screen_binding.dart';
import 'package:sunwise_project/app/modules/chat_screen/views/chat_screen_view.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/result_screen/bindings/result_screen_binding.dart';
import '../modules/result_screen/views/result_screen_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.RESULT_SCREEN,
      page: () => const ResultScreenView(),
      binding: ResultScreenBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_SCREEN,
      page: () => ChatScreenView(),
      binding: ChatScreenBinding(),
    ),
  ];
}
