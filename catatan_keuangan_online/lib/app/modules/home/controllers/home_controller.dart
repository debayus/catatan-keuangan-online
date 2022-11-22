import 'package:catatan_keuangan_online/app/mahas/mahas_config.dart';
import 'package:catatan_keuangan_online/app/modules/grafik/controllers/grafik_controller.dart';
import 'package:catatan_keuangan_online/app/modules/hutang_piutang/controllers/hutang_piutang_controller.dart';
import 'package:catatan_keuangan_online/app/modules/pengaturan/controllers/pengaturan_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../mahas/mahas_service.dart';
import '../../../mahas/services/helper.dart';
import '../../../mahas/services/mahas_format.dart';
import '../../transaksi/controllers/transaksi_controller.dart';

class HomeController extends GetxController {
  var transaksiCon = Get.put(TransaksiController());
  var grafikCon = Get.put(GrafikController());
  var hutangPiutangCon = Get.put(HutangPiutangController());
  var pengaturanCon = Get.put(PengaturanController());

  var tabIndex = 0.obs;

  final List<Map<String, dynamic>> menus = [
    {
      'label': 'Transaksi',
      'icon': FontAwesomeIcons.list,
    },
    {
      'label': 'Grafik',
      'icon': FontAwesomeIcons.chartPie,
    },
    {
      'label': 'Hutang Piutang',
      'icon': FontAwesomeIcons.handshake,
    },
    {
      'label': 'Pengaturan',
      'icon': FontAwesomeIcons.gear,
    },
  ];

  void bottomNavigationBarOnTab(v) {
    tabIndex.value = v;
    if (v == 0) {
      if (MahasConfig.refreshListTransaksi) {
        transaksiCon.listCon.refresh();
        MahasConfig.refreshListTransaksi = false;
      }
    } else if (v == 1) {
      if (MahasConfig.refreshGrafik) {
        grafikCon.refreshData();
        MahasConfig.refreshGrafik = false;
      }
    } else if (v == 2) {
      if (MahasConfig.refreshListHutangPiutang) {
        hutangPiutangCon.listCon.refresh();
        MahasConfig.refreshListHutangPiutang = false;
      }
    }
  }

  void checkVersion() async {
    final box = GetStorage();
    var now = DateTime.now();
    var updateDate = box.read<String>('update_date');
    if (updateDate != null) {
      if (DateTime.parse(updateDate).isAfter(now)) return;
    }
    var packageInfo = await PackageInfo.fromPlatform();
    var version = remoteConfig.getValue('version').asString();
    if (version != packageInfo.version) {
      var r = await Helper.dialogQuestion(
        message: 'Versi $version tersedia',
        textConfirm: 'Update',
      );
      if (r == true) {
        launchUrl(
          Uri.parse(remoteConfig.getValue('update_url').asString()),
          mode: LaunchMode.externalApplication,
        );
      } else {
        box.write(
            'update_date',
            MahasFormat.dateToString(
                DateTime(now.year, now.month, now.day + 7)));
      }
    }
  }

  @override
  void onInit() {
    checkVersion();
    super.onInit();
  }
}
