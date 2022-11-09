import 'package:catatan_keuangan_online/app/mahas/components/mahas_colors.dart';
import 'package:catatan_keuangan_online/app/mahas/components/mahas_themes.dart';
import 'package:catatan_keuangan_online/app/models/master_icon_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../controllers/pengaturan_rekening_setup_controller.dart';

class PengaturanRekeningSetupView
    extends GetView<PengaturanRekeningSetupController> {
  const PengaturanRekeningSetupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rekening'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nama Rekening",
                style: MahasThemes.muted,
              ),
              const Padding(padding: EdgeInsets.all(5)),
              TextField(
                decoration: MahasThemes.textFiendDecoration(
                  hintText: 'Nama Rekening',
                ),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              Text(
                "Icon",
                style: MahasThemes.muted,
              ),
              const Padding(padding: EdgeInsets.all(5)),
              ElevatedButton(
                onPressed: controller.iconOnPress,
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(60, 60),
                    backgroundColor: MahasColors.grey),
                child: Icon(
                  MasterIconModel.getIcon(controller.inputIcon.value) ??
                      FontAwesomeIcons.icons,
                  color: MahasColors.blue,
                ),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              Text(
                "Saldo",
                style: MahasThemes.muted,
              ),
              const Padding(padding: EdgeInsets.all(5)),
              TextField(
                decoration: MahasThemes.textFiendDecoration(
                  hintText: 'Saldo',
                ),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              ElevatedButton(
                onPressed: controller.submitOnPress,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Simpan"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
