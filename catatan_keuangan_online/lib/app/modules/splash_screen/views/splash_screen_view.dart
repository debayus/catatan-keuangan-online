import 'package:catatan_keuangan_online/app/mahas/mahas_colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MahasColors.primary,
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: SizedBox(
              width: 100,
              child: Image.asset(
                'assets/images/icon.png',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
