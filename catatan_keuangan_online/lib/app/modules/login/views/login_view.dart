import 'dart:io';
import 'package:catatan_keuangan_online/app/mahas/mahas_colors.dart';
import 'package:catatan_keuangan_online/app/mahas/components/mahas_themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../mahas/components/others/login_button.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MahasColors.primary,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            decoration: MahasColors.decoration,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(
                  child: Container(),
                ),
                SizedBox(
                  width: 150,
                  child: Image.asset(
                    'assets/images/icon.png',
                  ),
                ),
                const Padding(padding: EdgeInsets.all(5)),
                Text(
                  "Catatan Keuangan Online",
                  style: MahasThemes.h1,
                ),
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
                const Text("Login"),
                const Padding(padding: EdgeInsets.all(5)),
                LoginButton(
                  onPressed: controller.authCon.signInWithGoogle,
                  type: LoginButtonType.google,
                ),
                Visibility(
                  visible: Platform.isIOS,
                  child: Column(
                    children: [
                      const Padding(padding: EdgeInsets.all(2.5)),
                      LoginButton(
                        onPressed: controller.authCon.signInWithApple,
                        type: LoginButtonType.apple,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
                Visibility(
                  visible: false,
                  child: TextButton(
                    onPressed: controller.sampleOnPress,
                    child: const Text("Sample"),
                  ),
                ),
                Obx(() => Text(controller.version.value)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
