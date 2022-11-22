import 'package:catatan_keuangan_online/app/mahas/mahas_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'app/mahas/components/mahas_themes.dart';
import 'app/routes/app_pages.dart';

void main() async {
  await MahasService.init();

  runApp(
    GetMaterialApp(
      title: "Application",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: MahasThemes.light,
      builder: EasyLoading.init(),
    ),
  );
}
