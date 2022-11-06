import 'package:catatan_keuangan_online/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PengaturanController extends GetxController {
  var isLoading = false.obs;

  void hapusAkunOnPress() {
    if (isLoading.isTrue) return;
    Get.defaultDialog(
      title: 'Hapus Akun',
      middleText: 'Anda yakin akan menghapus akun ini?',
      textConfirm: 'Hapus',
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      cancelTextColor: Colors.grey,
      onConfirm: () async {
        Get.back();
        isLoading.value = true;
        var auth = Get.find<AuthController>();
        await auth.deleteAccount();
        isLoading.value = false;
      },
      onCancel: () {},
    );
  }
}
