import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    databaseURL:
        "https://sunwise-d0824-default-rtdb.asia-southeast1.firebasedatabase.app",
    apiKey: 'key',
    appId: '1:63952457289:android:cb05de138173ff44017998',
    messagingSenderId: '63952457289',
    projectId: 'sunwise-d0824',
  ));

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
