import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: controller.authCon.signInWithGoogle,
              child: const Text("Google Login"),
            ),
            ElevatedButton(
              onPressed: controller.authCon.signInWithApple,
              child: const Text("Apple Login"),
            ),
          ],
        ),
      ),
    );
  }
}
