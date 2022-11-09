import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pengaturan_jenis_pengeluaran_controller.dart';

class PengaturanJenisPengeluaranView
    extends GetView<PengaturanJenisPengeluaranController> {
  const PengaturanJenisPengeluaranView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PengaturanJenisPengeluaranView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PengaturanJenisPengeluaranView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
