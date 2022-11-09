import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pengaturan_jenis_pemasukan_controller.dart';

class PengaturanJenisPemasukanView
    extends GetView<PengaturanJenisPemasukanController> {
  const PengaturanJenisPemasukanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PengaturanJenisPemasukanView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PengaturanJenisPemasukanView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
