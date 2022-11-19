import 'package:catatan_keuangan_online/app/mahas/components/inputs/input_text_component.dart';
import 'package:catatan_keuangan_online/app/mahas/components/mahas_themes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../mahas/mahas_colors.dart';
import '../../../mahas/components/pages/setup_page_component.dart';
import '../../../models/master_icon_model.dart';
import '../controllers/pengaturan_rekening_setup_controller.dart';

class PengaturanRekeningSetupView
    extends GetView<PengaturanRekeningSetupController> {
  const PengaturanRekeningSetupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SetupPageComponent(
      controller: controller.formCon,
      title: 'Rekening',
      children: () => [
        InputTextComponent(
          label: 'Nama Rekening',
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
        Visibility(
          visible: controller.formCon.isState != SetupPageState.update,
          child: InputTextComponent(
            label: 'Saldo',
            controller: controller.saldoCon,
            required: true,
            editable: controller.formCon.editable,
          ),
        ),
      ],
    );
  }
}
