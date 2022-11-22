import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../mahas/components/inputs/input_text_component.dart';
import '../../../mahas/mahas_colors.dart';
import '../../../mahas/components/mahas_themes.dart';
import '../../../mahas/components/pages/setup_page_component.dart';
import '../../../models/master_icon_model.dart';
import '../controllers/pengaturan_jenis_pemasukan_setup_controller.dart';

class PengaturanJenisPemasukanSetupView
    extends GetView<PengaturanJenisPemasukanSetupController> {
  const PengaturanJenisPemasukanSetupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SetupPageComponent(
      controller: controller.formCon,
      title: 'Jenis Pemasukan',
      children: () => [
        InputTextComponent(
          label: 'Jenis Pemasukan',
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
                    backgroundColor: MahasColors.light.withOpacity(.5),
                  ),
                  child: Icon(
                    MasterIconModel.getIcon(controller.inputIcon.value) ??
                        FontAwesomeIcons.icons,
                    color: MahasColors.primary,
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
