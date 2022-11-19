import 'package:catatan_keuangan_online/app/controllers/auth_controller.dart';
import 'package:catatan_keuangan_online/app/mahas/mahas_colors.dart';
import 'package:catatan_keuangan_online/app/mahas/services/helper.dart';
import 'package:catatan_keuangan_online/app/routes/app_pages.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../mahas/models/menu_item_model.dart';

class PengaturanController extends GetxController {
  final List<MenuItemModel> menus = [];

  void rekeningOnPress() {
    Get.toNamed(Routes.PENGATURAN_REKENING);
  }

  void jenisPengeluaranOnPress() {
    Get.toNamed(Routes.PENGATURAN_JENIS_PENGELUARAN);
  }

  void jenisPemasukanOnPress() {
    Get.toNamed(Routes.PENGATURAN_JENIS_PEMASUKAN);
  }

  void userOnPress() {
    Get.toNamed(Routes.PENGATURAN_USER);
  }

  void hapusAkunOnPress() async {
    if (EasyLoading.isShow) return;
    var r = await Helper.dialogQuestion(
      message: 'Anda yakin akan menghapus akun ini?',
      textConfirm: 'Hapus',
      color: MahasColors.red,
    );
    if (r == true) {
      EasyLoading.show();
      var auth = Get.find<AuthController>();
      await auth.deleteAccount();
      EasyLoading.dismiss();
    }
  }

  void logOutOnPress() async {
    if (EasyLoading.isShow) return;
    EasyLoading.show();
    await Get.find<AuthController>().signOut();
    EasyLoading.dismiss();
  }

  @override
  void onInit() {
    super.onInit();

    menus.add(MenuItemModel(
        'Rekening', FontAwesomeIcons.creditCard, rekeningOnPress));
    menus.add(MenuItemModel('Jenis Pengeluaran',
        FontAwesomeIcons.fileInvoiceDollar, jenisPengeluaranOnPress));
    menus.add(MenuItemModel('Jenis Pemasukan',
        FontAwesomeIcons.handHoldingDollar, jenisPemasukanOnPress));
    menus.add(MenuItemModel('User', FontAwesomeIcons.user, userOnPress));
    menus.add(MenuItemModel(
        'Hapus Akun', FontAwesomeIcons.trashCan, hapusAkunOnPress));
    menus.add(MenuItemModel(
        'Sign out', FontAwesomeIcons.rightFromBracket, logOutOnPress));
  }
}
