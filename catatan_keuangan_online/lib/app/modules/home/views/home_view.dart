import 'package:catatan_keuangan_online/app/mahas/mahas_colors.dart';
import 'package:catatan_keuangan_online/app/modules/grafik/views/grafik_view.dart';
import 'package:catatan_keuangan_online/app/modules/hutang_piutang/views/hutang_piutang_view.dart';
import 'package:catatan_keuangan_online/app/modules/pengaturan/views/pengaturan_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../transaksi/views/transaksi_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MahasColors.blue,
      child: SafeArea(
        child: Scaffold(
          body: Obx(
            () => IndexedStack(
              index: controller.tabIndex.value,
              children: [
                TransaksiView(controller: controller.transaksiCon),
                GrafikView(controller: controller.grafikCon),
                HutangPiutangView(controller: controller.hutangPiutangCon),
                PengaturanView(controller: controller.pengaturanCon),
              ],
            ),
          ),
          bottomNavigationBar: Obx(
            () => BottomNavigationBar(
              showSelectedLabels: false,
              onTap: controller.bottomNavigationBarOnTab,
              currentIndex: controller.tabIndex.value,
              unselectedItemColor: Colors.white.withOpacity(0.4),
              selectedItemColor: Colors.white,
              items: controller.menus
                  .map(
                    (e) => BottomNavigationBarItem(
                      backgroundColor: MahasColors.blue,
                      icon: Icon(e['icon'], size: 25),
                      label: e['label'],
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
