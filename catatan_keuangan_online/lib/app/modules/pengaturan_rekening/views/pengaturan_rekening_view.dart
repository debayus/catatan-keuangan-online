import 'package:catatan_keuangan_online/app/mahas/components/shimmer_component.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../controllers/pengaturan_rekening_controller.dart';

class PengaturanRekeningView extends GetView<PengaturanRekeningController> {
  const PengaturanRekeningView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rekening'),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: controller.addOnPress,
              child: const Icon(
                FontAwesomeIcons.plus,
                size: 24,
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: controller.refreshModels,
        child: Obx(
          () => controller.isLoading.isTrue
              ? const ShimmerComponent()
              : ListView.separated(
                  itemBuilder: (context, index) => const ListTile(),
                  separatorBuilder: (context, index) => const Divider(
                    height: 0,
                  ),
                  itemCount: 10,
                ),
        ),
      ),
    );
  }
}
