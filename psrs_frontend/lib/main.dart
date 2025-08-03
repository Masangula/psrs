import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:psrs_frontend/app/services/storage_service.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(StorageService());
  // HttpOverrides.global = MyHttpOverrides();

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: (Get.find<StorageService>().isLoggedIn == true
          ? Routes.HOME
          : Routes.LOGIN),
      getPages: AppPages.routes,
    ),
  );
}
