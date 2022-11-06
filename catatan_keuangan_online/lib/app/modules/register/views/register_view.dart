import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const Center(
              child: Text(
                'RegisterView is working',
                style: TextStyle(fontSize: 20),
              ),
            ),
            ElevatedButton(
              onPressed: controller.lanjutkanOnPress,
              child: const Text("Lanjutkan"),
            ),
          ],
        ),
      ),
    );
  }
}
