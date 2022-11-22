import 'package:catatan_keuangan_online/app/mahas/mahas_colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MahasColors.cream,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: MahasColors.cream,
          body: Center(
            child: SizedBox(
              width: 150,
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
