import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pengaturan_jenis_pengeluaran_setup_controller.dart';
import 'package:catatan_keuangan_online/app/mahas/components/inputs/input_text_component.dart';
import 'package:catatan_keuangan_online/app/mahas/components/mahas_themes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../mahas/mahas_colors.dart';
import '../../../mahas/components/pages/setup_page_component.dart';
import '../../../models/master_icon_model.dart';

class PengaturanJenisPengeluaranSetupView
    extends GetView<PengaturanJenisPengeluaranSetupController> {
  const PengaturanJenisPengeluaranSetupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SetupPageComponent(
      controller: controller.formCon,
      title: 'Jenis Pengeluaran',
      children: () => [
        InputTextComponent(
          label: 'Jenis Pengeluaran',
          controller: controller.namaCon,
          required: true,
          editable: controller.formCon.editable,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Icon",
                style: MahasThemes.muted,
              ),
              const Padding(padding: EdgeInsets.all(2.5)),
              Obx(
                () => ElevatedButton(
                  onPressed: controller.formCon.editable
                      ? controller.iconOnPress
                      : null,
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(60, 60),
                      backgroundColor: MahasColors.grey),
                  child: Icon(
                    MasterIconModel.getIcon(controller.inputIcon.value) ??
                        FontAwesomeIcons.icons,
                    color: MahasColors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Padding(padding: EdgeInsets.all(10)),
      ],
    );
  }
}
