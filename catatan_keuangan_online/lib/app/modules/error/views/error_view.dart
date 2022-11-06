import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/error_controller.dart';

class ErrorView extends GetView<ErrorController> {
  const ErrorView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const Center(
              child: Text(
                'ErrorView is working',
                style: TextStyle(fontSize: 20),
              ),
            ),
            ElevatedButton(
              onPressed: controller.kembaliOnPress,
              child: const Text("Kembali"),
            ),
          ],
        ),
      ),
    );
  }
}
