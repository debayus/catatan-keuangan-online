import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pengaturan_controller.dart';

class PengaturanView extends GetView<PengaturanController> {
  const PengaturanView({
    Key? key,
    PengaturanController? controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Center(
            child: Text(
              'PengaturanView is working',
              style: TextStyle(fontSize: 20),
            ),
          ),
          ElevatedButton(
            onPressed: controller.hapusAkunOnPress,
            child: const Text("Hapus Akun"),
          ),
        ],
      ),
    );
  }
}
